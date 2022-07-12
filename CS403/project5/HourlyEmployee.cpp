#include <sstream>
#include "HourlyEmployee.h"
#include "Employee.h"

using namespace std;


HourlyEmployee::HourlyEmployee(const string& first, const string& last, const double& hours, const double& hourlyRt)
    : Employee(first, last)
{
    setHoursWorked(hours);
    setHourlyRate(hourlyRt);
}

double HourlyEmployee::getEarning() const{
    double hrs = getHoursWorked();
    double hrRt = getHourlyRate();
    double earned;
    if(hrs >= 40){
        if(hrs>=50){
            earned = 40*hrRt + 10*hrRt*1.5 + 2*(hrs-50)*hrRt;
        }
        else{
            earned = 40*hrRt + 1.5*(hrs-40)*hrRt;
        }
    }
    else{
        earned = hrs*hrRt;
    }
    return earned;
}


//getInfo()
string HourlyEmployee::getInfo() const
{
    std::string hrly  = to_string(getHourlyRate());
    hrly = hrly.substr(0, hrly.length()-4);
    std::string hrs  = to_string(getHoursWorked());
    hrs = hrs.substr(0, hrs.length()-4);
    std::string str = "Hourly employee: " + getFirstName() + " " + getLastName() + "\n" + "hours worked: " + hrs + ", hourly rate: " + hrly;
    return str;
}

void HourlyEmployee::setHoursWorked(const double& hours)
{
	hoursWorked = hours;
}

double HourlyEmployee::getHoursWorked() const
{
	return hoursWorked;
}

void HourlyEmployee::setHourlyRate(const double& rate)
{
	hourlyRate = rate;
}

double HourlyEmployee::getHourlyRate() const
{
	return hourlyRate;
}