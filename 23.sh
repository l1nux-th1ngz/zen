import tkinter as tk
from tkinter import messagebox
from tkcalendar import Calendar
from time import strftime

def copy_to_config():
    if copy_var.get() == 1:
        messagebox.showinfo("Copy to .config", "Directory copied to .config for faster and easier access.")

def show_calendar():
    cal = Calendar(root, selectmode="day", year=2023, month=1, day=1, bg='#282828', fg='white')
    cal.pack()

def update_time():
    string = strftime('%H:%M:%S %p')
    time_label.config(text=string)
    time_label.after(1000, update_time)

root = tk.Tk()
root.title("Package Installation Options")
root.configure(bg='#282828')  # Set background color

# Copy to .config checkbox
copy_var = tk.IntVar()
copy_checkbox = tk.Checkbutton(root, text="Copy to .config", variable=copy_var, bg='#282828', fg='white')
copy_checkbox.pack(pady=10)

# Install button
install_button = tk.Button(root, text="Install", command=copy_to_config, bg='#4CAF50', fg='white')
install_button.pack(pady=10)

# Calendar button
calendar_button = tk.Button(root, text="Show Calendar", command=show_calendar, bg='#2196F3', fg='white')
calendar_button.pack(pady=10)

# Clock label
time_label = tk.Label(root, font=('calibri', 20, 'bold'), background='#282828', foreground='white')
time_label.pack(anchor='center', pady=10)

# Update clock
update_time()

root.mainloop()
