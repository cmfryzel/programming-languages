#include <sstream>
#include "CommissionEmployee.h"

using namespace std;

CommissionEmployee::CommissionEmployee(const string& first, const string& last, const double& minSal, const double& salesAmt, const double& commissionRt)
    : Employee(first, last) 
{
    setMinSalary(minSal);
    setSalesAmount(salesAmt); 
    setCommissionRate(commissionRt);   
}

//getInfo()
string CommissionEmployee::getInfo() const
{
    std::string min  = to_string(getMinSalary());
    min = min.substr(0, min.length()-4);
    std::string sales  = to_string(getSalesAmount());
    sales = sales.substr(0, sales.length()-4);
    std::string comm  = to_string(getCommissionRate()*100);
    comm = comm.substr(0, comm.length()-4);
    std::string str = "aCommission employee: " + getFirstName() + " " + getLastName() + "\n" + "minimum salary: " + min + ", sales amount: " + sales + ", commission rate: " + comm + "%";
    return str;
}

double CommissionEmployee::getEarning() const{
    //calculate?
    double earned = getSalesAmount() * getCommissionRate();
    double min = getMinSalary();
    if(min>earned){
        return min;
    }
    return earned;
}

void CommissionEmployee::setMinSalary(const double& sal){
    minSalary=sal;
}
double CommissionEmployee::getMinSalary() const{
    return minSalary;
};

void CommissionEmployee::setSalesAmount(const double& salesAmt){
    salesAmount=salesAmt;
};
double CommissionEmployee::getSalesAmount() const{
    return salesAmount;
};

void CommissionEmployee::setCommissionRate(const double& commRt){
    commissionRate = commRt;
};
double CommissionEmployee::getCommissionRate() const{
    return commissionRate;
};
