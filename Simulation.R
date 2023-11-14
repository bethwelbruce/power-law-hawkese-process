# Import necessary libraries
library(matrixStats)

# Define the inverse compensator function
inverse_compensator <- function(T, A, N) {
  # Initialize the array of arrival times
  times <- c()
  
  # Simulate the arrival times
  t <- rexp(1, rate = 1)
  times <- c(times, t)
  for (i in 2:N) {
    t <- rexp(1, rate = 1)
    while (t > T) {
      t <- rexp(1, rate = 1)
    }
    times <- c(times, t)
  }
  
  # Thin out any points that arrive after T
  times <- times[times <= T]
  
  # Return the arrival times
  return(times)
}

# Define the power law Hawkes intensity function
power_hawkes_intensity <- function(t, times, k, c, D) {
  # Calculate the intensity
  intensity <- k * sum(1 / (c + (t - times))^D)
  
  # Return the intensity
  return(intensity)
}

# Simulate a power law Hawkes process with 100 points
times <- inverse_compensator(6, power_hawkes_intensity, 100)

# Plot the arrival times
plot(times, type = "l", xlab = "Time", ylab = "Arrival time", main = "Power law Hawkes process")


