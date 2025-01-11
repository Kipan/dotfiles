require('overseer').register_template({
    name = "Compile C project (recursive)",
    builder = function(params)
        -- Recursively find all .c files in the current directory and subdirectories
        local files = vim.fn.globpath(".", "**/*.c", 0, 1)
        return {
            cmd = "gcc",
            args = vim.tbl_flatten({
                "-g",  -- Include debugging information
                files, -- Add all .c files (including those in subdirectories)
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
    require('overseer').run_template({ name = "Compile C project (recursive)" })
end, { desc = "Run Compile C project with Overseer" })
