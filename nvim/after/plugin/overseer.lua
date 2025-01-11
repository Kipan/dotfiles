require('overseer').register_template({
    name = "Compile C project",
    builder = function(params)
        -- Find all C source files in the current directory
        local files = vim.fn.glob("*.c", 0, 1)
        return {
            cmd = "gcc",
            args = vim.tbl_flatten({
                "-g",  -- Include debugging information
                files, -- Add all C source files
                "-o", params.output, -- Specify output executable
            }),
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
