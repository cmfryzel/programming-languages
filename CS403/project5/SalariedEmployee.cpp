#include <sstream>
#include "SalariedEmployee.h"

using namespace std;

// SalariedEmployee::SalariedEmployee(void){
//     // setFirstName(" ");
//     // setLastName(" ");
//     // setSalariedRate(0);
//     // setHoursWorked(0);
// }

SalariedEmployee::SalariedEmployee(const string& first, const string& last, const double& salary)
    : Employee(first, last)
{
    
    setSalariedRate(salary);
}

double SalariedEmployee::getEarning() const{
    //calculate?
    double earned = getSalariedRate();
    return earned;
}

// void SalariedEmployee::setHoursWorked(const double& hours)
// {
// 	hoursWorked = hours;
// }

// double SalariedEmployee::getHoursWorked() const
// {
// 	return hoursWorked;
// }

void SalariedEmployee::setSalariedRate(const double& salary)
{
	salariedRate = salary;
}

double SalariedEmployee::getSalariedRate() const
{
	return salariedRate;
}

std::string truncate(std::string str){
    int len = str.length();
    str = str.substr(0, len-4);
    return str;
}

//getInfo()
string SalariedEmployee::getInfo() const
{
    std::string sal  = to_string(getSalariedRate());
    sal = sal.substr(0, sal.length()-4);
    std::string str = "Salaried employee: " + getFirstName() + " " + getLastName() + "\n" + "weekly salary: " + sal;
    return str;
}

