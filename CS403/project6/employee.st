Object subclass: Employee [
    | firstName lastName earned classification |
    <comment: 'I am a worker'>
    "<import: System Exceptions>
    <shape: #pointer>"
    "don't need to do the above"

    Employee class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]"base initialization for each employee"
    init [
        <category: 'initialization'>
        firstName := ''.
        lastName := ''.
        earned := 0.
        classification := ''.
    ]

"equivalent to Java toString"
    printOn: stream [
        <category: 'printing'>
        super printOn: stream.
        firstName printOn: stream.
        stream nextPutAll: ' '.
        lastName printOn: stream
    ]

"setters"
    setFName: fname[
        <category: 'setter'>
        firstName := fname.
    ]

    setLName: lname[
        <category: 'setter'>
        lastName := lname.
    ]


"getters"
    getFName [
        <category: 'getter'>
        ^firstName
    ]

    getLName [
        <category: 'getter'>
        ^lastName
    ]

    getEarned [
        <category: 'getter'>
        ^earned
    ]

    getStats [
        <category: 'getter'>
        | names |
        names := firstName, ' ', lastName.
        ^(names asString)
    ]    
]