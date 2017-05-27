## Actor Critic Notes

**Actor**

Also called _agent_

* State -> Action


**Critic**

Also called _value function_

* State, Action -> Reward

**Experience Replay**

It's not easy to learn temporally-correlated policies. Use the Critic  

**Reducing Variance using a baseline**

Subtracting from the value function another value function which approximates the general reward in this state. 

In other words - how good is it to be in this state compared to the baseline reward for this state.

This is called the _advantage function_.

##### Nomenclatur

**Off-Policy**: Updated policy separated from the behavioral policy (Q-Table and Sampling from Q-Table)

**On-Policy**: Updated and behavioral policy is the same

**Model-Free**: They don't try to learn the dynamics of the model,but rather the probability state-action function. If the state- or the actionspace is continuous, it does so with policy iteration or value iteration


**Policy-Based RL**

Adjusts the paramters theta of the policy (e.g weights of a NN) instead of correcting to the best action to pick from. 

Accepts state and returns a _single_ action.

Advantages:

* better convergence properties
* continuous action spaces
* stochastic policy is learnable (which may be optimal in a POMDP)

Disadvantages:

* converges often to a local maxima

**Value-Based RL**

Picks the best action in every state based on the experienced reward signal.

Advantages:
* will converge to the absolute best strategy

Disadvantages:
* can't handle big dimensionality or continuous actions
* deterministic policy
