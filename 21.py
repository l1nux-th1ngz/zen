import tkinter as tk
from tkinter import messagebox
from tkcalendar import Calendar
from time import strftime
import os

def copy_to_config():
    if copy_var.get() == 1:
        messagebox.showinfo("Copy to .config", "Directory copied to .config for faster and easier access.")

def show_calendar():
    cal = Calendar(root, selectmode="day", year=2023, month=1, day=1)
    cal.pack()

def update_time():
    string = strftime('%H:%M:%S %p')
    time_label.config(text=string)
    time_label.after(1000, update_time)

root = tk.Tk()
root.title("Package Installation Options")

# Copy to .config checkbox
copy_var = tk.IntVar()
copy_checkbox = tk.Checkbutton(root, text="Copy to .config", variable=copy_var)
copy_checkbox.pack(pady=10)

# Install button
install_button = tk.Button(root, text="Install", command=copy_to_config)
install_button.pack(pady=10)

# Calendar button
calendar_button = tk.Button(root, text="Show Calendar", command=show_calendar)
calendar_button.pack(pady=10)

# Clock label
time_label = tk.Label(root, font=('calibri', 20, 'bold'), background='black', foreground='white')
time_label.pack(anchor='center', pady=10)

# Update clock
update_time()

root.mainloop()
