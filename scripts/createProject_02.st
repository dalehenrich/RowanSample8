#!/usr/bin/gemstone/smalltalk
"
	Create a Rowan project from scratch, using all of the available defaults
"

	| projectName project |
	projectName := 'Example'.
	Rowan projectNamed: projectName ifPresent: [:project | project unload ].

	project := RwComponentProjectDefinition
		projectName: projectName 
			projectHome: '$ROWAN_PROJECTS_HOME'
			useGit: true
			comment: 'Example project exposing the standard project creation api'.
	project
		addComponentNamed: 'Core'
			comment: 'Primary component used for loading entire system.';
		addPackageNamed: 'Example-Core1'
			withConditions: { 'common' };
		addPackageNamed: 'Example-Core2'
			withConditions: { 'common' };
		addPackageNamed: 'Rowan-Tests'
			withConditions: { 'common' }
			andGroupName: 'tests';
		addPackageNamed: 'Example-GemStone-Extensions'
			withConditions: { 'gemstone' }
			gemstoneDefaultSymbolDictionaryForUser: 'SystemUser' -> 'Globals';
		addPackageNamed: 'Rowan-GemStone-Test-Extensions'
			withConditions: { 'gemstone' }
			andGroupName: 'tests'
			gemstoneDefaultSymbolDictionaryForUser: 'SystemUser' -> 'Globals';
		yourself

