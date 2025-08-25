# 🎮 Full_2D_Game  
*A simple and beautiful educational 2D game built with Godot*  

---

## 🌟 Core Mechanics  
- **Player Movement:** Move freely in 2D space to explore each level.  
- **Question Challenges:** Encounter math questions along the way.  
- **Time Limit:** Each level has a countdown timer for added challenge.  
- **Success Requirement:** Answer at least **70%** of questions correctly to pass.  
- **Failure Conditions:**  
  - Time runs out before reaching the requirement.  
  - Player falls into traps.  
- **Special Items:**  
  - Collecting a 💎 **Diamond** adds extra time to the countdown.  

---

## 🎯 Learning Goal  
This game encourages **problem-solving, quick thinking, and learning** in a fun and interactive way.  

---

## 📥 How to Download & Run the Game  

### 1. Download the Game Files  
1. Download the main project files:  
   <img width="300" height="300" alt="Download Files" src="https://github.com/user-attachments/assets/5677e36d-3510-406d-8935-468256ad6325" />  

2. Extract the downloaded archive:  
   <img width="300" height="300" alt="Extract Files" src="https://github.com/user-attachments/assets/da47a6b3-3a97-43b5-ae5e-2a70433fabd6" />  

---

### 2. Download Required AI Models  
- Download **User-bge-m3-q8_0.gguf**  
  👉 [Click Here](https://huggingface.co/alela32/USER-bge-m3-Q8_0-GGUF/blob/main/user-bge-m3-q8_0.gguf)  

- Download **Gemma-2-2b-it-Q4_K_M.gguf**  
  👉 [Click Here](https://huggingface.co/bartowski/gemma-2-2b-it-GGUF/blob/main/gemma-2-2b-it-Q4_K_M.gguf)  

- Place both files into the **Full_2D_game** folder.  

---

### 3. Install Godot  
- Download **Godot 4.3 (Stable)** from here:  
  👉 [Godot Download](https://godotengine.org/download/archive/4.3-stable/)  

- Open Godot and add the project.  

---

### 4. Configure AI Integration  
1. Open the **AssetLib** and search for **NobodyWHo**.  
2. Download and import it.  
3. Inside the project, go to **Ai_part** and delete the two existing scenes.  
4. Add the following child nodes:  
   - **NobodyWhoChat**  
   - **NobodyWhoModel**  
5. Link the **Gemma file** to *NobodyWhoModel*.  
6. Connect **NobodyWhoModel** → **NobodyWhoChat**.  

---

### 5. Run the Game 🎮  
- Press **F5** or click ▶ Run Project.  

✅ That’s it! Enjoy playing and hacking the game 🚀  

---

## 🛠️ Tech Stack  
- **Engine:** Godot 4.3  
- **Language:** GDScript  
- **AI Integration:** NobodyWho + GGUF Models  

---

## 💡 Future Improvements  
- Add more levels & question types  
- Enhance UI/UX design  
- Multiplayer quiz mode  

---

## 📜 License  
This project is for **educational and personal use**.  
