return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    config = function()
        local dap = require("dap")
        local ui = require("dapui")

        require("dapui").setup()

        local netcoredbg = vim.fn.exepath "netcoredbg"
        if netcoredbg ~= "" then
            dap.adapters.coreclr = {
                type = "executable",
                command = netcoredbg,
                args = { "--interpreter=vscode" },
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "Launch",
                    task = "run",
                    request = "launch",
                    program = function()
                        return vim.fn.input "Path to dll"
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = false,
                    console = "internalConsole",
                },
            }
        end

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

        vim.keymap.set("n", "<F5>", dap.continue)
        vim.keymap.set("n", "<F6>", dap.step_into)
        vim.keymap.set("n", "<F7>", dap.step_over)
        vim.keymap.set("n", "<F8>", dap.step_out)
        vim.keymap.set("n", "<F9>", dap.step_back)
        vim.keymap.set("n", "<F12>", dap.restart)

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end
    end,
}
