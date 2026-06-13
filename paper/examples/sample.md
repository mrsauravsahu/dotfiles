---
title: Mermaid Diagram Samples
author: the paper project
---

# Flowchart

```mermaid
flowchart TD
    A[Start] --> B{Is it working?}
    B -- Yes --> C[Great!]
    B -- No --> D[Debug]
    D --> B
```

# Sequence Diagram

```mermaid
sequenceDiagram
    participant Client
    participant API
    participant DB

    Client->>API: POST /login
    API->>DB: SELECT user WHERE email=?
    DB-->>API: user row
    API-->>Client: 200 OK + JWT
```

# Entity Relationship

```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ LINE_ITEM : contains
    PRODUCT ||--o{ LINE_ITEM : "referenced by"
    CUSTOMER {
        int id
        string name
        string email
    }
    ORDER {
        int id
        date placed_at
    }
    LINE_ITEM {
        int quantity
        float unit_price
    }
    PRODUCT {
        int id
        string name
        float price
    }
```

# State Diagram

```mermaid
stateDiagram-v2
    [*] --> Draft
    Draft --> Review : submit
    Review --> Approved : approve
    Review --> Draft : request changes
    Approved --> Published : publish
    Published --> [*]
```

# Gantt Chart

```mermaid
gantt
    title Project Timeline
    dateFormat  YYYY-MM-DD
    section Design
    Wireframes       :a1, 2024-01-01, 7d
    Mockups          :a2, after a1, 5d
    section Development
    Backend          :b1, after a2, 14d
    Frontend         :b2, after a2, 14d
    section QA
    Testing          :c1, after b1, 7d
    Bug fixes        :c2, after c1, 5d
```

# Pie Chart

```mermaid
pie title Traffic Sources
    "Organic Search" : 42
    "Direct" : 28
    "Referral" : 18
    "Social" : 12
```

# Git Graph

```mermaid
gitGraph
    commit id: "init"
    branch feature/auth
    checkout feature/auth
    commit id: "add login"
    commit id: "add JWT"
    checkout main
    merge feature/auth
    commit id: "bump version"
```
