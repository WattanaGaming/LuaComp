local compiler = {}
compiler.actions = {
    shift = 0,
    reduce = 1,
}
compiler.states = {
    declare = 0,
}

function compiler.compile(tokens)
    local codeBuffer = ""
    local stack = {}

    local function pushBuffer(text)
        codeBuffer = codeBuffer .. text
    end

    for line,data in ipairs(tokens) do
        for index,token in ipairs(data) do
            pushBuffer(token.data)
        end
        pushBuffer("\n")
    end

    return codeBuffer
end
