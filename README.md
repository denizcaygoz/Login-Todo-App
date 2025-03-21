# Flutter Todo App - User Authentication & Task Management

## Overview

This is a **Flutter** application which allows users to **register, log in, and create  todo lists**. The app interacts with a **Spring Boot backend** for authentication and data storage. JWT tokens are used in API requests to ensure secure access to the backend.
🔗 **[Login-Todo-App Backend Project](https://github.com/denizcaygoz/Login-Todo-App-Backend)** 
---

## Features

- **User Authentication**: Login and Signup using JWT.
- **Todo List**: Create, update, and delete todo list of a user.
- **Local Storage**: Uses **Hive** and **Shared Preferences** for local storage.
- **REST API**: Communicates with a Spring Boot backend.
- **State Management**: Uses **Flutter Bloc** for state management.
- **Auto Token Refresh**: Refreshes JWT token periodically.

---

### Authentication Endpoints

| Method | Endpoint | Description |
| --- | --- | --- |
| `POST` | `/auth/login` | Login with email and password |
| `POST` | `/auth/register` | Register a new user |

### Todo Endpoints

| Method | Endpoint | Description |
| --- | --- | --- |
| `GET` | `/user/todolist` | Fetch user's todo list |
| `POST` | `/user/todolist` | Update user's todo list |
