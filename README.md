# 🎮 Full_2D_Game  
*A simple and beautiful educational 2D game built with Godot*  

---

## 🌟 Core Mechanics  
- **Player Movement:** Move freely in 2D space to explore each level.  
- **Question Challenges:** Encounter math questions along the way.  
- **Time Limit:** Each level has a countdown timer for added challenge.  
- **Success Requirement:** Answer at least **10** of questions correctly to pass.  
- **Failure Conditions:**  
  - Time runs out before reaching the requirement.   
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
  <img width="1626" height="618" alt="Download Model 1" src="https://github.com/user-attachments/assets/5e50e0fc-ab53-48b0-8212-8aa0da7d4bdd" />  

- Download **Gemma-2-2b-it-Q4_K_M.gguf**  
  👉 [Click Here](https://huggingface.co/bartowski/gemma-2-2b-it-GGUF/blob/main/gemma-2-2b-it-Q4_K_M.gguf)  
  <img width="1589" height="596" alt="Download Model 2" src="https://github.com/user-attachments/assets/2dda68e3-dcfd-40e9-8547-ba1858899118" />  

- Place both files into the **Full_2D_game** folder:  
  <img width="1916" height="738" alt="Place Models" src="https://github.com/user-attachments/assets/2cc95ac6-0fd9-48cb-b87c-713520cf8cb6" />  

---

### 3. Install Godot  
- Download **Godot 4.3 (Stable)** from here:  
  👉 [Godot Download](https://godotengine.org/download/archive/4.3-stable/)  

- Open Godot and add the project:  
  <img width="1142" height="450" alt="Open Godot" src="https://github.com/user-attachments/assets/e7241131-852a-4400-8302-71ca3913f4f6" />  

- Double click the game folder:  
  <img width="1049" height="735" alt="Select Folder" src="https://github.com/user-attachments/assets/17ba4494-278c-47ea-949f-f99af6907139" />  

- Press **Open**:  
  <img width="1050" height="735" alt="Press Open" src="https://github.com/user-attachments/assets/eb68c288-3d86-4941-ba82-83ce210f0ec3" />  

---

### 4. Configure AI Integration  

#### 🔹 Step 1: Install NobodyWHo Plugin  
Go to **AssetLib**, search for **NobodyWHo**, and download it:  
<img width="1249" height="368" alt="Search NobodyWHo" src="https://github.com/user-attachments/assets/2767b9cf-0d8b-4cc7-888a-879baad35fb7" />  

Click **Download**:  
<img width="1100" height="549" alt="Download NobodyWHo" src="https://github.com/user-attachments/assets/fa05fd7b-e591-47e3-bffa-ec2af41f1c57" />  

---

#### 🔹 Step 2: Clean Old AI Scenes  
Navigate to **Ai_part** and delete the two old scenes:  
<img width="259" height="311" alt="Ai_part folder" src="https://github.com/user-attachments/assets/40c79437-21df-4025-b04a-3a7b704b1c8b" />  
<img width="273" height="354" alt="Delete old scenes" src="https://github.com/user-attachments/assets/b4784c0a-eaf9-4272-814a-f8f58ad3a7c6" />  

---

#### 🔹 Step 3: Add New Nodes  
Add child nodes → search for:  
- **NobodyWhoChat**  
- **NobodyWhoModel**  

<img width="430" height="481" alt="Add Child Node" src="https://github.com/user-attachments/assets/2b4b876c-f911-4989-afd7-ca46862dbdcb" />  
<img width="892" height="727" alt="Add NobodyWho Nodes" src="https://github.com/user-attachments/assets/3179daaf-910c-4b0d-8d99-3446daaae32b" />  

They should look like this:  
<img width="272" height="422" alt="Final Node Tree" src="https://github.com/user-attachments/assets/0a1cd897-517a-4af1-a195-6989713396a8" />  

---

#### 🔹 Step 4: Connect the AI Model  
- Select **NobodyWhoModel** and add the **Gemma file**:  
  <img width="1432" height="741" alt="Add Gemma File" src="https://github.com/user-attachments/assets/43deff7b-2936-44ad-a6d8-db1e0cfee5a2" />  

- Connect **NobodyWhoModel** to **NobodyWhoChat**:  
  <img width="1110" height="750" alt="Connect Model to Chat" src="https://github.com/user-attachments/assets/4fedb453-c43a-4eea-9339-74419885c457" />  

---

### 5. Run the Game 🎮  
- Press **F5** or click ▶ Run Project.  
  <img width="415" height="282" alt="Run Game" src="https://github.com/user-attachments/assets/a64604a4-62ed-4dca-9f87-139727a55e98" />  

✅ That’s it! Enjoy playing and hacking the game 🚀  

game demo : https://drive.google.com/file/d/1fs9B_28QUG6uh2nqFbGIkE8C2wmFC0X1/view?usp=sharing
 
