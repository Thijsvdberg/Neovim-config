function fileNameToClass(fileName)
-- strsub
    return string.sub(fileName, 0, string.len(fileName)-3)
end


return {
    s("cls", f(function(args, snip)
        local res, env = {}, snip.env
        table.insert(res, "namespace Mountain;")
        table.insert(res, "")
        table.insert(res, "public sealed class " .. fileNameToClass(env.TM_FILENAME))
        table.insert(res, "{")
        table.insert(res, "")
        table.insert(res, "}")
        return res
    end, {}))
}
