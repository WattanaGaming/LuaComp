local argparse = require("argparse")
local serpent = require("serpent")

local parser = argparse("luacomp", "A general purpose Lua preprocessor/postprocessor")

parser:argument("input", "The source .lua file to compile")
parser:option("-o --output", "The output .lua file to compile to", "a.lua")

local args = parser:parse()

-- Make sure the input file exists and is a .lua file
do
    local f = io.open(args.input)
    if f ~= nil then -- File exists
        if args.input:match("^.+(%..+)$") ~= ".lua" then
            print("The input file \""..args.input.."\" is not a .lua file.")
            os.exit()
        end
    else
        print("The input file \""..args.input.."\" does not exist.")
        os.exit()
    end
end

--#include "src/includes/lex.lua"
print("Building tokens...")

local tokens = {}
do
    local file = io.open(args.input, "r")
    local content = file:read("a")
    tokens = lex(content)
end

--#include "src/compiler.lua"
print("Compiling...")
do
    local file = io.open(args.output, "w")
    file:write(compiler.compile(tokens))
    file:close()
end
