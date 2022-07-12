Object subclass: EmployeesCollected [
    | employeeCollection |
    <comment: 'reads dat file'>

    EmployeesCollected class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]

    init [
        <category: 'initialization'>
        employeeCollection := OrderedCollection new.
    ]

    count: list [
        | listSize |

        employeeCollection := list.

        listSize := 'There are ', employeeCollection size asString, ' employees'.

        Transcript show: listSize; cr.
    ]

    total: list [
        | tot finalString |

        employeeCollection := list.

        tot := 0.

       "iterate over collection and print"
       employeeCollection do: [:employeeCollection | tot := ((employeeCollection getEarned) + tot)].
        
        finalString := 'Total payment is $', (tot asNumber asScaledDecimal: 2) asString.

        Transcript show: finalString; cr.
    ]

    avg: list [
        | tot finalString ave |

        employeeCollection := list.

        tot := 0.

        ave := 0.

        "iterate over collection and print"
        employeeCollection do: [:employeeCollection | tot := ((employeeCollection getEarned) + tot)].
        
        ave := (tot / (employeeCollection size)) asNumber asScaledDecimal: 2.

        finalString := 'Average payment per employee is $', ave asString.
    
        Transcript show: finalString; cr.
    ]

    print: list [
        | listSize n |

        employeeCollection := list.

        listSize := employeeCollection size.

        n := 1.

        "iterate over collection and print"
        employeeCollection do: [:employeeCollection | Transcript show: employeeCollection getStats; cr.
                (n = listSize)
                    ifTrue:[ ^nil ]
                    ifFalse:[ Transcript cr ].
                    n := n + 1.
            ].
    ]

    min: list [
        | minimum currentMinimum minimumEmployee |

        employeeCollection := list.

        minimum := employeeCollection first getEarned.

        "iterate over collection and print"
        employeeCollection do: [:employeeCollection | 
            currentMinimum := employeeCollection getEarned.
            (currentMinimum < minimum)
                ifTrue: [
                    minimum := currentMinimum.
                    minimumEmployee := employeeCollection.
                ]
            ].
        
        Transcript show: minimumEmployee getStats; cr.
    ]

    max: list [
        | maximum currentMaximum maximumEmployee |

        employeeCollection := list.

        maximum := employeeCollection first getEarned.

        "iterate over collection and print"
        employeeCollection do: [:employeeCollection | 
            currentMaximum := employeeCollection getEarned.
            (currentMaximum > maximum)
                ifTrue: [
                    maximum := currentMaximum.
                    maximumEmployee := employeeCollection.
                ]
            ].
        
        Transcript show: maximumEmployee getStats; cr.
    ]
]

| fileCheck argumentCount employeesList action operator threshold |


employeesList := OrderedCollection new. "employees"

employeeCollection := EmployeesCollected new. "actions"

argumentCount := Smalltalk getArgc.

(argumentCount == 4 or: [argumentCount == 2])
    ifFalse: [
            first := 'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st action', Character nl asString, 'or', Character nl asString, 'Usage: gst employee.st salaried.st hourly.st commission.st -f main.st action operator threshold'.
            second := 'Valid actions: count print min max total avg'.
            third := 'Valid operators: eq ne gt ge lt le'.

            finalString := first, Character nl asString, Character nl asString, second, Character nl asString, third.
            Transcript show: finalString; cr.
            ObjectMemory quit.
    ].

"always have an action if argumentCount is 2 or 4."
action := Smalltalk arguments at: 2.

"only have operator and threshould if argumentCount is 4."
(argumentCount == 4)
    ifTrue: [
        operator := Smalltalk arguments at: 3.
        threshold := Smalltalk arguments at: 4.
    ].

fileCheck := FileStream open: Smalltalk arguments first mode: FileStream read ifFail: [
    "give error message when unable to open"
    "Smalltalk arguments at: 1 doesn't work-- why?"
    
    Transcript show: 'Unable to open ', Smalltalk arguments first, ' for reading'; cr.
    ObjectMemory quit.
].

[fileCheck atEnd] whileFalse: [
    | lines parsedLines |

    lines := fileCheck upTo: Character nl.

    parsedLines := lines substrings.

    "initialize the type of employee after parsing"
    (parsedLines includes: 'hourly')
        ifTrue: [
            Emp := HourlyEmployee new.
            Emp setFName: (parsedLines at: 2); setLName: (parsedLines at: 3); setHoursWorked: (parsedLines at: 4); setHourlyRate: (parsedLines at: 5).
            employeesList add: Emp.
        ].

    (parsedLines includes: 'salaried')
        ifTrue: [
            Emp := SalariedEmployee new.
            Emp setFName: (parsedLines at: 2); setLName: (parsedLines at: 3); setEarned: (parsedLines at: 4).
            employeesList add: Emp.
        ].

    (parsedLines includes: 'commission')
        ifTrue: [
            Emp := CommissionEmployee new.
            Emp setFName: (parsedLines at: 2); setLName: (parsedLines at: 3); setMinSalary: (parsedLines at: 4); setSalesAmount: (parsedLines at: 5); setCommissionRate: (parsedLines at: 6).
            employeesList add: Emp.
        ].        
].

(employeesList size == 0)
    
    ifTrue: [
        Transcript show: 'There are no employees'; cr.
        ObjectMemory quit.
    ].


(argumentCount == 4)
    ifTrue: [
        | thr money |
        
        threshold := threshold asInteger.

        thr := OrderedCollection new.
        "make a list that has the threshold"
        "iterate over the employee list to see if the employee passes threshold based on operator."
        employeesList do: [ :employeesList | 
            money := (employeesList getEarned) asInteger.
            (operator = 'eq') ifTrue: [ (money = threshold) ifTrue: [ thr add: employeesList ] ].
            (operator = 'ne') ifTrue: [ (money ~= threshold) ifTrue: [ thr add: employeesList ] ].
            (operator = 'ge') ifTrue: [ (money >= threshold) ifTrue: [ thr add: employeesList ] ].
            (operator = 'le') ifTrue: [ (money <= threshold) ifTrue: [ thr add: employeesList ] ].
            (operator = 'gt') ifTrue: [ (money > threshold) ifTrue: [ thr add: employeesList ] ].
            (operator = 'lt') ifTrue: [ (money < threshold) ifTrue: [ thr add: employeesList ] ].    

        ].

        "loop through ones that meet threshold to see if it qualifies for action."
            (action = 'count') ifTrue: [ employeeCollection count: thr ].
            (action = 'print') ifTrue: [ employeeCollection print: thr ].
            (action = 'min') ifTrue: [ employeeCollection min: thr ].
            (action = 'max') ifTrue: [ employeeCollection max: thr ].
            (action = 'total') ifTrue: [ employeeCollection total: thr ].
            (action = 'avg') ifTrue: [ employeeCollection avg: thr ].
    ].

(argumentCount == 2)
    ifTrue: [
        (action = 'count') ifTrue: [ employeeCollection count: employeesList ].
        (action = 'print') ifTrue: [ employeeCollection print: employeesList ].
        (action = 'min') ifTrue: [ employeeCollection min: employeesList  ].
        (action = 'max') ifTrue: [ employeeCollection max: employeesList ].
        (action = 'total') ifTrue: [ employeeCollection total: employeesList ].
        (action = 'avg') ifTrue: [ employeeCollection avg: employeesList ].
    ].
