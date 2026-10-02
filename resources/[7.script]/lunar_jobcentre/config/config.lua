Config = {}
Config.RenderDistance = 30.0
Config.Target = 'ox_target' --['ox_target'/'qtarget']

Config.Blip = {
	Text = 'Pole emploi',
	Sprite = 498,
	Size = 0.5,
	Color = 26,
	Display = 4
}

Config.Locations = {
	{
		Ped = `a_f_y_business_01`,
		Coords = vector4(-232.3107, -915.4592, 32.3108, 337.3374),
	}
}

--Optional fontawesome icons for jobs.
Config.JobIcons = {
	['unemployed'] = 'fa-solid fa-user',
	['taxi'] = 'fa-solid fa-taxi',
	['trucker'] = 'fa-solid fa-truck',
}

Config.Licenses = {
	{
		Item = 'id_card',
		Label = 'carte d\'identité',
		Icon = 'fa-solid fa-id-card',
		LicenseNeeded = false, --['license'/false] verify license ownership through esx_license
		Price = 100
	},
	{
		Item = 'license_drive',
		Label = 'permis de conduire',
		Icon = 'fa-solid fa-car',
		LicenseNeeded = 'dmv', --['license'/false] verify license ownership through esx_license
		Price = 100
	},
	{
		Item = 'license_weapon',
		Label = 'Permis d\'arme',
		Icon = 'fa-solid fa-gun',
		LicenseNeeded = 'weapon', --['license'/false] verify license ownership through esx_license
		Price = 100
	},
}
