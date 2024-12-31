(module feline-config)

(local lualine (require :lualine))
(local colors {:bg "#1e2030"
               :blue "#8bd5ca"
               :cyan "#7dc4e4"
               :darkblue "#8aadf4"
               :fg "#bbc2cf"
               :green "#a6da95"
               :magenta "#c6a0f6"
               :orange "#f5a97f"
               :red "#ed8796"
               :violet "#a9a1e1"
               :yellow "#eed49f"})
(local conditions
       {:buffer_not_empty (fn []
                            (not= (vim.fn.empty (vim.fn.expand "%:t")) 1))
        :check_git_workspace (fn []
                               (local filepath (vim.fn.expand "%:p:h"))
                               (local gitdir
                                      (vim.fn.finddir :.git (.. filepath ";")))
                               (and (and gitdir (> (length gitdir) 0))
                                    (< (length gitdir) (length filepath))))
        :hide_in_width (fn [] (> (vim.fn.winwidth 0) 80))})
(local config {:inactive_sections {:lualine_a {}
                                   :lualine_b {}
                                   :lualine_c {}
                                   :lualine_x {}
                                   :lualine_y {}
                                   :lualine_z {}}
               :options {:component_separators ""
                         :section_separators ""
                         :theme {:inactive {:c {:bg colors.bg :fg colors.fg}}
                                 :normal {:c {:bg colors.bg :fg colors.fg}}}}
               :sections {:lualine_a {}
                          :lualine_b {}
                          :lualine_c {}
                          :lualine_x {}
                          :lualine_y {}
                          :lualine_z {}}})
(fn ins-left [component] (table.insert config.sections.lualine_c component))
(fn ins-right [component] (table.insert config.sections.lualine_x component))
(ins-left {1 (fn [] "▊")
           :color {:fg colors.blue}
           :padding {:left 0 :right 1}})
(ins-left {1 (fn [] "")
           :color (fn []
                    (local mode-color
                           {"\019" colors.orange
                            "\022" colors.blue
                            :! colors.red
                            :R colors.violet
                            :Rv colors.violet
                            :S colors.orange
                            :V colors.blue
                            :c colors.magenta
                            :ce colors.red
                            :cv colors.red
                            :i colors.green
                            :ic colors.yellow
                            :n colors.red
                            :no colors.red
                            :r colors.cyan
                            :r? colors.cyan
                            :rm colors.cyan
                            :s colors.orange
                            :t colors.red
                            :v colors.blue})
                    {:fg (. mode-color (vim.fn.mode))})
           :padding {:right 1}})
(ins-left {1 :filesize :cond conditions.buffer_not_empty})
(ins-left {1 :filename
           :color {:fg colors.magenta :gui :bold}
           :cond conditions.buffer_not_empty})
(ins-left [:location])
(ins-left {1 :progress :color {:fg colors.fg :gui :bold}})
(ins-left {1 :diagnostics
           :diagnostics_color {:error {:fg colors.red}
                               :info {:fg colors.cyan}
                               :warn {:fg colors.yellow}}
           :sources [:nvim_diagnostic]
           :symbols {:error " " :info " " :warn " "}})
(ins-left [(fn [] "%=")])
(ins-left {1 (fn []
               (let [msg "No Active Lsp"
                     buf-ft (vim.api.nvim_get_option_value :filetype {:buf 0})
                     clients (vim.lsp.get_clients)]
                 (when (= (next clients) nil) (lua "return msg"))
                 (each [_ client (ipairs clients)]
                   (local filetypes client.config.filetypes)
                   (when (and filetypes
                              (not= (vim.fn.index filetypes buf-ft) (- 1)))
                     (let [___antifnl_rtn_1___ client.name]
                       (lua "return ___antifnl_rtn_1___"))))
                 msg))
           :color {:fg "#ffffff" :gui :bold}
           :icon " LSP:"})
(ins-right {1 "o:encoding"
            :color {:fg colors.green :gui :bold}
            :cond conditions.hide_in_width
            :fmt string.upper})
(ins-right {1 :fileformat
            :color {:fg colors.green :gui :bold}
            :fmt string.upper
            :icons_enabled false})
(ins-right {1 :branch :color {:fg colors.violet :gui :bold} :icon ""})
(ins-right {1 :diff
            :cond conditions.hide_in_width
            :diff_color {:added {:fg colors.green}
                         :modified {:fg colors.orange}
                         :removed {:fg colors.red}}
            :symbols {:added " " :modified "󰝤 " :removed " "}})
(ins-right {1 (fn [] "▊") :color {:fg colors.blue} :padding {:left 1}})
(lualine.setup config)

; (local prov-lsp (require :feline.providers.lsp))
; (local prov-vi-mode (require :feline.providers.vi_mode))
; (local prov-file (require :feline.providers.file))
; (local prov-git (require :feline.providers.git))


; (local force-inactive
;   {:filetypes
;    [:NvimTree
;     :dbui
;     :packer
;     :startify
;     :fugitive
;     :fugitiveblame]
;    :buftypes []
;    :bufnames []})

; (local components {:active [{} {} {}] :inactive [{} {} {}]})

; (local catppuccin {:bg "#1e1e2e"
;                    :black "#181926"
;                    :yellow "#f9e2af"
;                    :cyan "#94e2d5"
;                    :oceanblue "#89b4fa"
;                    :green "#a6e3a1"
;                    :orange "#fab387"
;                    :violet "#cba6f7"
;                    :magenta "#eba0ac"
;                    :white "#f5e0dc"
;                    :fg "#f5e0dc"
;                    :skyblue "#74c7ec"
;                    :red "#f38ba8"
;                    :grey "#494d64"})

; (local vi-mode-colors {:NORMAL :green
;                        :OP :green
;                        :INSERT :red
;                        :CONFIRM :red
;                        :VISUAL :skyblue
;                        :LINES :skyblue
;                        :BLOCK :skyblue
;                        :REPLACE :violet
;                        :V-REPLACE :violet
;                        :ENTER :cyan
;                        :MORE :cyan
;                        :SELECT :orange
;                        :COMMAND :green
;                        :SHELL :green
;                        :TERM :green
;                        :NONE :yellow})

; (set force-inactive.buftypes [:terminal])

; ; Checks if passed variable is a component
; (fn component? [component]
;   (if (= nil (. component :provider))
;     false
;     true))

; ; Add component or list of components to section
; (fn add-component [section]
;   (fn [component_]
;     (if (component? component_)
;         (tset section (+ 1 (length section)) component_)
;         (each [index component (ipairs component_)]
;           ((add-component section) component)))))

; (local register-active-left (add-component (. components.active 1)))
; (local register-active-middle (add-component (. components.active 2)))
; (local register-active-right (add-component (. components.active 3)))

; (local side-indicator
;   {:provider " "
;    :hl (fn []
;          (local val {})
;          (set val.bg (prov-vi-mode.get_mode_color))
;          (set val.fg :black)
;          (set val.style :bold)
;          val)
;    :right_sep " "})

; (local vi-mode
;   {:provider :vi_mode
;    :hl (fn []
;          (local val {})
;          (set val.fg (prov-vi-mode.get_mode_color))
;          (set val.bg :bg)
;          (set val.style :bold)
;          val)
;    :right_sep " "
;    :show_mode_name true})

; (local git-branch
;   {:provider :git_branch :hl {:fg :yellow :bg :bg :style :bold}
;    :left_sep " "})

; (fn git-has-changes? []
;   (local changes vim.b.gitsigns_status_dict)
;   (if (= changes nil)
;       false
;       (let
;         [has-additions (not= (. changes :added) 0)
;          has-changes (not= (. changes :changed) 0)
;          has-removals (not= (. changes :removed) 0)]
;         (or has-additions (or has-changes has-removals)))))
; (fn git-diff [type]
;   (let [gsd vim.b.gitsigns_status_dict]
;     (if (and (and gsd (. gsd type)) (> (. gsd type) 0))
;       (tostring (. gsd type))
;       "0")))
; (fn pad [string padding width]
;   (let [amount-to-pad (- width (length string))]
;     (.. (string.rep padding amount-to-pad) string)))


; (local git-start-section
;   {:provider "["
;    :enabled (fn [] (git-has-changes?))
;    :hl {:fg :grey :bg :bg :style :bold}
;    :left_sep " "})
; (local git-added
;   {:provider (fn [] (.. " " (pad (git_diff "added") " " 2)))
;    :enabled (fn [] (git-has-changes?))
;    :hl {:fg :green :bg :bg :style :bold}
;    :left_sep ""})
; (local git-changed
;   {:provider (fn [] (.. " " (pad (git_diff "removed") " " 2)))
;    :enabled (fn [] (git-has-changes?))
;    :hl {:fg :orange :bg :bg :style :bold}
;    :left_sep " "})
; (local git-removed
;   {:provider (fn [] (.. " " (pad (git_diff "changed") " " 2)))
;    :enabled (fn [] (git-has-changes?))
;    :hl {:fg :red :bg :bg :style :bold}
;    :left_sep " "})
; (local git-end-section
;   {:provider "]"
;    :enabled (fn [] (git-has-changes?))
;    :hl {:fg :grey :bg :bg :style :bold}
;    :right_sep " "})

; (local filename
;   {:provider {:name :file_info :opts {:type "relative-short" :file_modified_icon ""}}
;    :icon ""
;    :hl (fn []
;           (local val {})
;           (set val.fg (prov-vi-mode.get_mode_color))
;           (set val.bg :bg)
;           (set val.style :bold)
;           val)})

; (local file-type
;   {:provider (fn []
;               (.. "[" (prov-file.file_type {} { :icon ""}) "]"))
;    :hl {:fg :white :bg :bg :style :bold}
;    :left_sep " "})

; ; Formats lsp.util.get_progress_messages response
; ; Source: https://github.com/beauwilliams/statusline.lua/blob/20ad26912935f91918da9f428761b6d1b651d632/lua/sections/_lsp.lua#L44-L58
; (fn format-messages [messages]
;   (let [result {}]
;     (var i 1)
;     (each [_ msg (pairs messages)]
;       (when (< i 3)
;         (table.insert result (.. (or msg.percentage 0) "%% " (or msg.title "")))
;         (set i (+ i 1))))
;     (table.concat result " ")))

; (fn lsp-connected? []
;   (not= (next (vim.lsp.buf_get_clients 0)) nil))

; (local lsp-status
;   {:provider (fn []
;                (local messages (vim.lsp.status))
;                (if (= (length messages) 0)
;                  "+LSP"
;                  (.. " " messages)))
;    :hl {:fg :violet :bg :bg :style :bold}
;    :enabled (fn []
;               (lsp-connected?))
;    :left_sep " "})

; (fn lsp-has-diagnostics? []
;   (not= 0 (length (vim.diagnostic.get 0 {}))))

; (fn lsp-diagnostics-count [type]
;   (let [count (vim.tbl_count (vim.diagnostic.get 0 {:severity type}))]
;     (or (and (not= count 0) (tostring count)) "0")))

; (local lsp-start-section
;   {:provider "["
;    :enabled (fn [] (lsp-connected?))
;    :hl {:fg :grey :bg :bg :style :bold}
;    :left_sep " "})
; (local lsp-errors
;   {:provider (fn [] (.. " " (pad (lsp-diagnostics-count vim.diagnostic.severity.ERROR) " " 1)))
;    :enabled (fn [] (lsp-connected?))
;    :hl {:fg :red :style :bold}
;    :left_sep ""})
; (local lsp-warnings
;   {:provider (fn [] (.. " " (pad (lsp-diagnostics-count vim.diagnostic.severity.WARN) " " 1)))
;    :enabled (fn [] (lsp-connected?))
;    :hl {:fg :yellow :style :bold}
;    :left_sep " "})
; (local lsp-hints
;   {:provider (fn [] (.. " " (pad (lsp-diagnostics-count vim.diagnostic.severity.HINT) " " 1)))
;    :enabled (fn []
;               (prov-lsp.diagnostics_exist vim.diagnostic.severity.HINT))
;    :hl {:fg :cyan :style :bold}
;    :left_sep " "})
; (local lsp-infos
;   {:provider (fn [] (.. " " (pad (lsp-diagnostics-count vim.diagnostic.severity.INFO) " " 1)))
;    :enabled (fn []
;               (prov-lsp.diagnostics_exist vim.diagnostic.severity.INFO))
;    :hl {:fg :skyblue :style :bold}
;    :left_sep " "})
; (local lsp-end-section
;   {:provider "]"
;    :enabled (fn [] (lsp-connected?))
;    :hl {:fg :grey :bg :bg :style :bold}
;    :right_sep " "})

; (local file-size
;       {:provider :file_size
;        :hl {:fg :cyan :bg :bg :style :bold}
;        :right_sep " "})
; (local position
;   {:provider {:name :position :opts {:padding true}}
;        :hl {:fg :skyblue :bg :bg :style :bold}
;        :right_sep " "})
; (local percentage
;       {:provider :line_percentage
;        :hl {:fg :oceanblue :bg :bg :style :bold}
;        :right_sep " "})


; (register-active-left side-indicator)
; (register-active-left vi-mode)
; (register-active-left git-branch)
; (register-active-left [git-start-section git-added git-changed git-removed git-end-section])

; (register-active-middle filename)
; (register-active-middle file-type)
; (register-active-middle lsp-status)

; (register-active-right [lsp-start-section lsp-errors lsp-warnings lsp-hints lsp-infos lsp-end-section])
; (register-active-right [file-size position percentage])

; ((. (require :feline) :setup) {:theme catppuccin
;                                :default_bg bg
;                                :default_fg fg
;                                :vi_mode_colors vi-mode-colors
;                                : components
;                                :force_inactive force-inactive})
