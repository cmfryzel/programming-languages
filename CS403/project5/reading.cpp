#include <sstream>
#include <fstream>
#include <iostream>
#include "reading.h"
#include "CommissionEmployee.h"
#include "SalariedEmployee.h"
#include "HourlyEmployee.h"

using namespace std;

//.cpp
vector<Employee*> *readFrom(std::string filename){
    vector<Employee*> *pointer = new vector<Employee*>;
    //add Employee objects to vector
    //loop
        //if(commission)
        //if(salaried)
        //if(hourly)
        //pointer.push_back(Employee)
    //endloop
    
    std::ifstream data;
    data.open(filename);
    if(!data.is_open()) {return pointer;}

    std::string word;
    vector<string> words;

    while(data >> word){
        words.push_back(word);
    }
    int i = 0;
    while(i<words.size()){
        string &typeOfEmp = words[i];
        if(typeOfEmp=="commission"){
            std::string & firstName = words[i+1];
            std::string & lastName = words[i+2];
            std::string & minSal = words[i+3];
            std::string & salesAmt = words[i+4];
            std::string & commRt = words[i+5];

            i+=6;

            CommissionEmployee* comm = new CommissionEmployee(firstName, lastName, stod(minSal), stod(salesAmt), stod(commRt));
            pointer->push_back(comm);
        }
        else if(typeOfEmp=="salaried"){
            std::string & salary = words [i+3];
            std::string & firstName = words[i+1];
            std::string & lastName = words[i+2];

            i+=4;

            SalariedEmployee* sal = new SalariedEmployee(firstName, lastName, stod(salary));
            pointer->push_back(sal);            
        }
        else if(typeOfEmp=="hourly"){

            std::string & firstName = words[i+1];
            std::string & lastName = words[i+2];

            std::string hrsWorked = words[i+3];
            std::string hrlyRate = words[i+4];

            i+=5;

            HourlyEmployee* hour = new HourlyEmployee(firstName, lastName, stod(hrsWorked), stod(hrlyRate));
            pointer->push_back(hour);   
        }
    }
    
    //}
    return pointer;
}
//.h
//std::vector<Employee*> *readFrom(std::string);
