# power-law-hawkese-process
convert this python file to r
import numpy as np

def inverse_compensator(T, A, N): # see Section 4.1
  """Simulates a point process using the inverse compensator method.

  Args:
    T: The end time of the simulation.
    A: The compensator function.
    N: The number of points to simulate.

  Returns:
    An array of arrival times.
  """

  times = np.empty(N, dtype=np.float64)
  t = -np.log(np.random.rand())
  times[0] = t
  for i in range(1, N):
    t += -np.log(np.random.rand())
    while t > T:
      t -= -np.log(np.random.rand())
    times[i] = t

  # Thin out any points that arrive after T
  times = times[times <= T]

  return times

def power_hawkes_intensity(t, times, k, c, D):
  """Calculates the intensity of a power law Hawkes process at time t.

  Args:
    t: The time at which to calculate the intensity.
    times: An array of arrival times of previous events.
    k: The interaction strength.
    c: The decay rate.
    D: The refractory period.

  Returns:
    The intensity of the process at time t.
  """

  intensity = k * sum(1 / (c + (t - t_i))**D for t_i in times)
  return intensity

# Simulate a power law Hawkes process with 100 points
times = inverse_compensator(6, power_hawkes_intensity, 100)

# Plot the arrival times
import matplotlib.pyplot as plt

plt.plot(times)
plt.xlabel('Time')
plt.ylabel('Arrival time')
plt.title('Power law Hawkes process')
plt.show()
