Employee subclass: SalariedEmployee [
    | earned |
    <comment: 'I am an employee with a weekly salary.'>

    SalariedEmployee class >> new [
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
        classification := 'Salaried'.
        earned := 0
    ]


    "getters"
    getStats [
        <category: 'getter'>
        | names firstPart secondPart thirdPart total |
        "concatenate names" 
        names := firstName, ' ', lastName.
        firstPart := classification, ' employee: ', names.
        secondPart := 'weekly salary: ', (self getEarned) asString.
        thirdPart :=  'earned $', (self getEarned) asString.
        total := firstPart, Character nl asString, secondPart, Character nl asString, thirdPart.
        ^total    
    ]

    getEarned [
        <category: 'getter'>
        ^(earned asNumber asFraction asScaledDecimal: 2)
    ]
    
    "setters"
    setEarned: earnd [
        <category: 'setter'>
        earned := earnd.
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