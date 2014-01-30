# Description: Generate table assignments for `num_customers` customers, according to
# Chinese Restaurant Process with dispersion parameter `alpha`.
# Returns an integer vector of table assignments

chinese_restaurant_process = function(num_customers, alpha)
{
if (num_customers <= 0) stop("Need a positive amount of customers") 

table_assignments = c(1) # first customer sits at table 1
next_open_table = 2  # index of the next empty table

for (i in 1:(num_customers-1))
  {
  if (runif(n=1) < alpha / (alpha + i))
    {
    table_assignments = c(table_assignments, next_open_table)
    next_open_table = next_open_table + 1
    }
  else
    {
      # Customer sits at an existing table.
      # He chooses which table to sit at by giving equal weight to each
      # customer already sitting at a table.
    which_table = table_assignments[sample(length(table_assignments),size=1)]
    table_assignments = c(table_assignments,which_table)
    }
  }

return(table_assignments)  
}

num_tables = function(num_customers,alpha)
  {
  k = 1:num_customers  
  expected_val_tables = sum(alpha/(alpha+k-1))
  return(expected_val_tables)
  }

upper_bound = function(num_customers,alpha)
  { 
  return(ifelse(alpha<2,2.5,1) * ifelse(alpha<0.2,2,1) * alpha * log(num_customers))
  }

