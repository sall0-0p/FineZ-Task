**Scripting Task — Hybrid OOP / Data-Oriented Debuff System**

> **Task Overview**  
> Please write an example implementation of a **debuff system** in Luau. The goal is to design a hybrid between Object-Oriented Programming (OOP) and Data-Oriented Design (DOD).

---

> **System Requirements**  
> We want two key components:

---

> **→ 1. Debuff Class Object (Mutable Runtime Data)**
>  
> Each active debuff should be an object that stores:  
> • **EntityID** → The ID of the entity this debuff is applied to  
> • **EndTime** → When the debuff expires (using `os.clock()`)  
> • **NextTick** → When the next tick should run (using `os.clock()` and the tick interval from the schema)
>  
> **Responsibilities of the Debuff object:**  
> • Call the schema’s **OnApplied()** method during construction  
> • Call the schema’s **OnRemoved()** method during `:Destroy()`  
> • Call the schema’s **OnTick()** each time the tick interval elapses, passing:  
>    → **EntityID**  
>    → The schema’s **UniqueStatusData**  
> • Manage a **Heartbeat connection**:  
>    → Check each frame whether:  
>      • The debuff should run **OnTick()**  
>      • The debuff has expired (and automatically destroy itself)

---

> **→ 2. Debuff Schema (Static Configuration Data)**
>  
> Each debuff type should define a **schema** that stores:  
> • **TickInterval** → Time in seconds between ticks  
> • **Duration** → Total time in seconds the debuff lasts  
> • **UniqueStatusData** → Dictionary with any debuff-specific values (e.g. damage per tick, movement speed changes, etc.)  
> • Functions:  
>    → **OnApplied(entityId, uniqueStatusData)**  
>    → **OnRemoved(entityId, uniqueStatusData)**  
>    → **OnTick(entityId, uniqueStatusData)**

---

> **Usage Flow**
>  
> • You call the Debuff class **.new(...)** constructor  
>     → Initializes the debuff  
>     → Calls the schema’s **OnApplied()**  
> • The Debuff object stores its schema reference  
> • The Debuff object uses a **Heartbeat connection** to:  
>     → Call **OnTick()** when needed  
>     → Destroy itself when its **EndTime** is reached, ensuring cleanup and calling **OnRemoved()**

---

> **Your Task**
>  
> • Implement this system in Luau  
> • Show:  
>     → One example **schema** (e.g. a “Burning” debuff that deals damage over time)  
>     → Creation of a Debuff object for an entity  
>     → Ticking logic running via Heartbeat  
>     → Automatic cleanup on expiry
>  
> The code doesn’t have to be production-grade or handle every edge case — focus on showing **architecture, clarity, and understanding of the pattern.**
>  
> Let me know if you have any questions!
