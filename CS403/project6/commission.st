Employee subclass: CommissionEmployee [
    | minSalary salesAmount commissionRate |
    <comment: 'I am an employee who gets commission maybe'>

    CommissionEmployee class >> new [
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
        minSalary := 0.
        salesAmount := 0.
        commissionRate := 0.
        earned := 0.
        classification := 'Commission'.
        " ^super init "
    ]


    "getters"
    getEarned [
        <category: 'getter'>
        earned := (((salesAmount asNumber) * (commissionRate asNumber)) asScaledDecimal: 2) asString.
        (minSalary asNumber < earned asNumber)
            ifTrue: [
                ^(earned asNumber asFraction asScaledDecimal: 2)
            ].
        ^(minSalary asNumber asFraction asScaledDecimal: 2)
    ]

    getStats [
        <category: 'getter'>
        | names firstPart secondPart thirdPart total|
        "concatenate names" 
        names := firstName, ' ', lastName.
        firstPart := classification, ' employee: ', names.
        secondPart := 'minimum salary: ', (minSalary asNumber asFraction asScaledDecimal: 2) asString, ', sales amount: ', (salesAmount asNumber asFraction asScaledDecimal: 2) asString, ', commission rate: ', (((commissionRate asNumber) * 100) asFraction asScaledDecimal: 2) asString, '%'.
        thirdPart :=  'earned $', (self getEarned) asString.
        total := firstPart, Character nl asString, secondPart, Character nl asString, thirdPart.
        ^total
    ]

    "setters"
    setSalesAmount: salesAmt [
        <category: 'setter'>
        salesAmount := salesAmt.
    ]
    setMinSalary: minSal [
        <category: 'setter'>
        minSalary := minSal.
    ]
    setCommissionRate: commRt [
        <category: 'setter'>
        commissionRate := commRt.
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