# qb-shoplifting

A resource where you can shoplift items from stores
Where you can shoplift is configurable and how much you get from shoplifting is also Configurable

This resource uses qb-target
To make the target work you need to add these following lines in init.lua and Config.TargetModels 

	    ["stealing"] = {
        models = {
            "v_ret_247shelves01",
            "v_ret_247shelves02",
            "v_ret_247shelves03",
            "v_ret_247shelves04",
            "v_ret_247shelves05"
        },
        options = {
            {
                type = "client",
                event = "qb-shoplifting:client:doStuff",
                icon = "fas fa-toolbox",
                label = "Shoplift",
            }
        },
        distance = 1.0
    },

	    ["stealAlc"] = {
        models = {
            "v_ret_ml_liqshelfc",
        },
        options = {
            {
                type = "client",
                event = "qb-shoplifting:client:shopLift",
                icon = "fas fa-toolbox",
                label = "Shoplift Alcohol",
            }
        },
        distance = 1.0
    },
        
        
