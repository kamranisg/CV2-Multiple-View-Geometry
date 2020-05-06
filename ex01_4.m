% Return sum of primes between s and e
function sum1 = ex01(s,e)
    sum1=0;
    for i=s:1:e
        if(isprime(i))
            sum1=sum1+i;
        end
       
end
