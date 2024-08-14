state("DetroitBecomeHuman")
{
    byte Loading: "DetroitBecomeHuman.exe", 0x02A15610, 0x440, 0x10, 0x430, 0x2C8, 0x8;
    string38 CurrentGameState: "DetroitBecomeHuman.exe", 0x02B43EC8, 0xB0;
}

startup
{
    vars.chapters = new Dictionary<string, string> {
        {"0101 Hostage", "The Hostage"},
        {"0101K Alice - Part 1 _Sav Shop_", "Openning"},
        {"0101M The Painter - District", "Shades of Color"},
        {"0102K Alice - Part 2 _Todd House_", "A New Home"},
        {"0102M The Painter - Carl House", "The Painter"},
        {"0201C Teammates", "Partners"},
        {"0201K Dark Night", "Stormy Night"},
        {"0201M Broken", "Broken"},
        {"0401C The Interrogation", "The Interrogation"},
        {"0301K Fugitives", "Fugitives"},
        {"0301M Mass Grave", "From the Dead"},
        {"0301C Police Works", "Waiting for Hank…"},
        {"0401K On The Run", "On the Run"},
        {"0501M Jericho", "Jericho"},
        {"0501C The Nest", "The Nest"},
        {"0601M Time To Decide", "Time to Decide"},
        {"0501K Zlatko", "Zlatko"},
        {"0601C Russian Roulette", "Russian Roulette"},
        {"0602M Spare Parts", "Spare Parts"},
        {"0601C Eden Club", "The Eden Club"},
        {"0701K Fun fair", "The Pirates’ Cove"},
        {"0801C The vault ambassador bridge", "The Bridge"},
        {"0703M Big Screen Building", "The Stratford Tower"},
        {"0901C Back To Big Screen Food Truck", "Public Enemy"},
        {"0801K A place to hide", "Midnight Train"},
        {"0801M Night Of The Long Knives Jericho", "Capitol Park"},
        {"1101C Meet Kamski", "Meet Kamski"},
        {"1001M We Are People", "Freedom March"},
        {"1201C Lockers", "Last Chance, Connor"},
        {"1202C Lockers", "Last Chance, Connor (Any%)"},
        {"02A Crossroads", "Crossroads"},
        {"03A Night Of The Soul", "Night of the Soul"},
        {"04A Final", "Battle for Detroit"}
    };
    foreach (var tag in vars.chapters) {
        settings.Add(tag.Key, true, tag.Value);
        }

    // This is to check if you have Compare Against -> Real Time instead of Game Time
        if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var mbox = MessageBox.Show(
            "Removing loads from Detroit: Become Human requires comparing against Game Time.\nWould you like to switch to it?",
            "LiveSplit | Detroit: Become Human",
            MessageBoxButtons.YesNo);

        if (mbox == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}


start
{
    return (current.CurrentGameState == "0101 Hostage" && old.CurrentGameState == "MENU");
}

split
{
    return (current.CurrentGameState != old.CurrentGameState) && (old.CurrentGameState != "MENU")
    && settings[current.CurrentGameState];
}

isLoading
{
    return (current.Loading == 1);
}

exit
{
    timer.IsGameTimePaused = true;
}
