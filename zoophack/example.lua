local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/UI-LIBRARIES/refs/heads/main/zoophack/source.lua"))();

local window = library:new({name = "zoophack", sub = ".rape"}); do
    local main_page = window:page({name = "zomg zoophack "}); do
        local section = main_page:section({name = "main section WTFFF", size = "auto"}); do
            local checkbox = section:toggle({name = "rape all", default = false, flag = "test111", callback = function(v)
                warn(v);
            end});

            local slider = section:slider({name = "moneys $", min = 0, max = 100, default = 50, callback = function(v)
                warn(v);
            end});

            local dropdown = section:dropdown({name = "how many moneys $", options = {"$500000", "$1000000"}, callback = function(v)
                warn(v);
            end});

            local colorpicker = section:colorpicker({name = "moneys color.", default = Color3.fromRGB(100, 255, 0), callback = function(v)
                warn(v);
            end});

            local keybind = section:keybind({name = "rape all", default = Enum.KeyCode.F, callback = function(v)
                warn(v);
            end});
        end

        local multi_section = main_page:multisection({name = "multi section", size = "auto", side = "right"}); do
            local section1 = multi_section:section({name = "section 1", size = "auto"}); do
                section1:toggle({name = "raped DSADSADSA all", default = false, flag = "test111", callback = function(v)
                    warn(v);
                end});
            end

            local section2 = multi_section:section({name = "section 21", size = "auto", side = "right"}); do
                section2:toggle({name = "rape all 2222", default = false, flag = "test113331", callback = function(v)
                    warn(v);
                end});
            end
        end
    end

    local other_page = window:page({name = "ZOOPPHACK SECOND TAB"}); do
        local section = other_page:section({name = "ANOTHER SECTION"}); do
            local checkbox = section:toggle({name = "togglepicker", default = false, flag = "test111", callback = function(v)
                warn(v);
            end}):colorpicker({name = "rape color.", default = Color3.fromRGB(255, 255, 255), callback = function(v)
                warn(v);
            end});

            local checkbox = section:toggle({name = "togglekeypicker", default = false, flag = "test111", callback = function(v)
                warn(v);
            end}):keybind({name = "rape all", default = Enum.KeyCode.E, callback = function(v)
                warn(v);
            end});
        end

        local preview = other_page:section({name = "preview", side = "right", size = "auto"}); do
            local esp_preview = preview:preview({}); do
                esp_preview:set_visibility("box", true);
                esp_preview:set_visibility("healthbar", true);
                esp_preview:set_visibility("name", true);
                esp_preview:set_visibility("distance", true);
                esp_preview:set_visibility("weapon", true);
            end
        end
    end

    library:notify({text = "this a notif", time = 60});
end

library:set_open(true)
