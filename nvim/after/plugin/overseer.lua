require('overseer').register_template({
    name = "Compile C project",
    builder = function(params)
        -- Dynamically include all .c files in the current directory
        local cwd = vim.fn.expand('%:p:h') -- Directory of the current file
        local c_files = vim.fn.glob(cwd .. '/*.c', false, true) -- List of all .c files in the directory

        return {
            cmd = "gcc",
            args = vim.list_extend({ "-g", "-o", params.output }, c_files),
            components = { "default" },
        }
    end,
    params = {
        output = {
            type = "string",
            default = "a.out",
            description = "Output executable",
        },
    },
    priority = 50,
    condition = {
        filetype = { "c" },
    },
})

vim.keymap.set("n", "<leader>cc", function()
    require('overseer').run_template({ name = "Compile C project" })
end, { desc = "Run Compile C project with Overseer" })
