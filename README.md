
# Neural Network-based Model Predictive Control 
Control simulation of a mechanical system using NN-MPC in a model-based reinforcement learning (RL) algorithm.
![Screenshot](mass-spring-damper.png)

Suppose we have three identical point masses m = 0.5 kg, with initial positions x1, x2, and x3. The dampers have damping constant d= 0.25 N.s/m each. The springs are nonlinear, described by the Newton’s law as:

### F(x) = k.Δx^3 + kp.Δx^3,

with k = 217 N/m, and kp= 63.5 N/m³. 

#### The main goal here is to steer the masses m1 and m3 to its desired reference position values x1_ref and x3_ref. An artificial neural network will be used to predict its future positions x1 and x3 based on the forces u1, dist, and u3.

## Model-based RL Framework
Designed framework to solve the task
![framework](flowchartreinf.png)

The pseudo algorithm is:
![algo](algo.png)

Final result:
without disturbance:
![result](changemassreinf.png)
with disturbance:
![result2](dist100changemassreinf.png)
More details: https://stephenadhi.medium.com/model-based-rl-for-nonlinear-dynamics-control-a-case-study-70c31810f255

Feel free to ask if you have any questions.
