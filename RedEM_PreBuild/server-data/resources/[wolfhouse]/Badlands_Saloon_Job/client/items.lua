function GetItemNameFromHash(hash)
    if hash == GetHashKey("p_bread05x") then
        return "bread"
    elseif hash == GetHashKey("p_bottleBeer01x") then
        return "beer"
    elseif hash == GetHashKey("s_inv_whiskey02x") then
        return "good_whisky"
	elseif hash == GetHashKey("p_bottlenavyrum01X") then
        return "dirty_whiskey"
	elseif hash == GetHashKey("p_cigarette_cs01x") then
        return "cigarettes"
	elseif hash == GetHashKey("p_bowl04x_stew") then
        return "goulash"
	elseif hash == GetHashKey("p_capicola_meat") then
        return "capocollo"
	elseif hash == GetHashKey("p_cigar01x") then
        return "cigar"
	elseif hash == GetHashKey("p_water01x") then
        return "water"
	elseif hash == GetHashKey("p_mugcoffee01x") then
        return "coffee"
	elseif hash == GetHashKey("s_drinkshootmg02x") then
        return "lemonade"
	elseif hash == GetHashKey("p_teasugar") then
        return "minttea"
	elseif hash == GetHashKey("p_bottlewine01x") then
        return "wine"
	elseif hash == GetHashKey("p_bottlewine03x") then
        return "champagne"
elseif hash == GetHashKey("P_WHISKEYGLASS01X") then
        return "lemonade"
    end
end