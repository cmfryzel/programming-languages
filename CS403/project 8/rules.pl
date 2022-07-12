% pay rules
% salaried
pay(F, L, P) :- salaried(F, L, Salary),
        P is Salary.
% hourly
pay(F, L, P) :- hourly(F, L, Hours, Rate),
        Hours >= 50,
        P is (Rate * 40 + (15 * Rate) + (Hours - 50) * Rate * 2).
pay(F, L, P) :- hourly(F, L, Hours, Rate),
        Hours >= 40,
        Hours < 50,
        P is (Rate * 40 + (Hours - 40) * 1.5 * Rate).
pay(F, L, P) :- hourly(F, L, Hours, Rate),
        Hours =< 40,
        P is Rate*Hours.
% commission
pay(F, L, P) :- commission(F, L, Min, Sales, Crate),
                    Sales*Crate > Min,
                    P is Sales*Crate.
pay(F, L, P) :- commission(F, L, Min, Sales, Crate),
                    Sales*Crate =< Min,
                    P is Min.


