#include <TMB.hpp>
template<class Type>
Type objective_function<Type>::operator() ()
{
  DATA_VECTOR(dv);
  PARAMETER(x);
  Type f = 0.0;
  Type dv1 = dv[1];
  return f;
}
