Employee subclass: HourlyEmployee [
    | hoursWorked hourlyRate earned |
    <comment: 'I am an employee that gets an hourly wage.'>

    HourlyEmployee class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]

    init [
        <category: 'initialization'>
        firstName := ''.
        lastName := ''.
        classification := 'Hourly'.
        hoursWorked := 0.
        hourlyRate := 0.
        earned := 0
        "^super init"
    ]

    "getters"
    getEarned [
        <category: 'getter'>
        (hoursWorked asNumber > 50)
            ifTrue: [
                earned := (40 * hourlyRate asNumber) + (10 * (hourlyRate asNumber * 1.5)) + ((2 * hourlyRate asNumber) * (hoursWorked asNumber - 50))
            ].
        ((hoursWorked asNumber <= 50) & (hoursWorked asNumber > 40))
            ifTrue: [
                earned := (40 * hourlyRate asNumber) + ((hoursWorked asNumber - 40) * (hourlyRate asNumber * 1.5))
            ].
        (hoursWorked asNumber <= 40)
            ifTrue: [
                earned := ((hoursWorked asNumber) * (hourlyRate asNumber))
            ].
        ^(earned asNumber asFraction asScaledDecimal: 2)
    ]

    getStats [
        <category: 'getter'>
        | names firstPart secondPart thirdPart total|
        "concatenate names" 
        names := firstName, ' ', lastName.
        firstPart := classification, ' employee: ', names.
        secondPart := 'hours worked: ', (hoursWorked asNumber asFraction asScaledDecimal: 2) asString, ', hourlyRate: ', (hourlyRate asNumber asScaledDecimal: 2) asString.
        thirdPart :=  'earned $', (self getEarned) asString.
        total := firstPart, Character nl asString, secondPart, Character nl asString, thirdPart.
        ^total    
    ]


    "setters"
    setHoursWorked: hrsWrkd [
        <category: 'setter'>
        hoursWorked := hrsWrkd.
    ]

    setHourlyRate: hrlyRt [
        <category: 'setter'>
        hourlyRate := hrlyRt.
    ]

    "toString thing"
    printOn: stream [
        <category: 'printing'>
        classification printOn: stream.
        stream nextPutAll: ' employee: '.
        firstName printOn: stream.
        stream nextPutAll: ' '.
        lastName printOn: stream.
    ]
]