Config = {}

Config.Jobs = {
    ["police"] = {
        Name = "New Hanover Sheriff's Office",
        HasDuty = true,
        HasLockers = true,
        MenuLocations = {
            vector3(-278.3807, 805.3717, 119.43005), -- Valentine - NH
            vector3(2904.144, 1309.9204, 44.937969), -- Annesburg - NH
        },
        Grades = {
            [1] = {
                Name = "Assistant Deputy",
                Pay = 3.50,
            },
            [2] = {
                Name = "Deputy",
                Pay = 4.75,
                StorageAccess = true,
            },
            [3] = {
                Name = "Senior Deputy",
                Pay = 5.25,
                StorageAccess = true,
            },
            [4] = {
                Name = "Corporal",
                Pay = 6.75,
                StorageAccess = true,
            },
            [5] = {
                Name = "Sergeant",
                Pay = 7.75,
                StorageAccess = true,
            },
            [6] = {
                Name = "Lieutenant",
                Pay = 8,
                Personnel = true,
                Ledger = true,
                StorageAccess = true,
            },
            [7] = {
                Name = "Captain",
                Pay = 8.75,
                Personnel = true,
                Ledger = true,
                StorageAccess = true,
            },
            [8] = {
                Name = "Undersheriff",
                Pay = 9,
                Personnel = true,
                Ledger = true,
                StorageAccess = true,
            },
            [9] = {
                Name = "Sheriff",
                Pay = 9.50,
                Personnel = true,
                Ledger = true,
                StorageAccess = true,
            },
        }
    },
}