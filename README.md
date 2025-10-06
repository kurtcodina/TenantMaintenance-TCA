# TenantMaintenance-TCA

I spent Sunday diving deep into **The Composable Architecture (TCA)** — watching talks, reading guides, and experimenting with examples on GitHub — and decided to apply what I learned by recreating two of the maintenance screens from the **August App** marketing materials.

This project is an experiment to better understand TCA’s core ideas and how they fit into building real-world SwiftUI features.

---

##Screenshots

---

##What I’ve Learned

TCA’s power comes from its **clarity and structure**. Some of the key concepts I’ve been exploring:

- **State** – A single source of truth for each feature. Every view renders from explicit, observable state.
- **Action** – The only way to mutate state. User interactions, delegate callbacks, and async effects all express intent through actions.
- **Reducer** – Pure functions that handle actions and describe how state changes. Reducers can be composed to build complex features out of smaller ones.
- **Store** – The runtime engine that binds state, actions, and reducers together. Views send actions and observe state through the store.
- **Effects** – Asynchronous work (like API calls, file writes, etc.) expressed as testable, cancellable units.
- **Dependency Injection** – TCA encourages passing dependencies (network, database, date, UUID, etc.) explicitly, improving testability.
- **Navigation and State Scoping** – Each screen manages its own domain, but navigation between them is expressed through scoped state and actions.

---

##What I’m Building

I’m recreating **two key screens** from the August App marketing materials using TCA:
1. **Maintenance Report List**
2. **Report Detail / Edit View**

Each screen is built around its own reducer and state, connected through navigation paths.  
The focus is on modeling data flow clearly — not on full feature parity (yet).

---

##Next Steps

- Improve **Path Navigation** to handle deep linking and consistent state restoration.
- Add **unit and integration tests** for reducers and effects.
- Experiment with **dependencies** for image uploads, photo pickers, and persistence.
- Explore **Reducer composition** to better organize nested domains.

---

##Reflection

TCA initially feels strict, but the more I build, the more I see its value — it forces a clear separation between logic and UI, and it makes features easier to reason about.  
I’ll keep iterating and refining this project as I learn more about navigation, testing, and architecture patterns.

---

##Tech Stack

- **SwiftUI**
- **The Composable Architecture (TCA)**
- **iOS 17+**
- **Xcode 16**

---