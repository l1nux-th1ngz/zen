import tkinter as tk
import os
from tkinter import messagebox
from tkcalendar import Calendar
from time import strftime

class Window:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Package Installation Options")
        self.root.configure(bg='#282828')  # Set background color
        self.widgets_builder()
        # Grab the saved data
        getdata(self)
        self.binding()
        self.root.mainloop()

    def widgets_builder(self):
        self.label1()
        self.entry1()
        self.listbox()
        self.label2()

    def label1(self):
        self.lab1 = tk.Label(
            self.root, text="Enter to add items, \nSelect to delete Items,\n ctr+s to save",
            bg="gold")
        self.lab1.pack(fill="both")

    def entry1(self):
        self.v = tk.StringVar()
        self.entry = tk.Entry(self.root, textvariable=self.v, font=24)
        self.entry.pack(fill="both")
        self.entry.focus()

    def listbox(self):
        self.lv = tk.Variable()
        self.lst = tk.Listbox(self.root, listvariable=self.lv)
        self.lst.pack(side=tk.LEFT, fill=tk.BOTH, expand=1)

    def label2(self):
        self.label = tk.Label(self.root, text="Press enter to add an item",
            bg="gold")
        self.label.pack(fill="both")

    def binding(self):
        self.lst.bind("<Double-Button>", lambda x: delete(x, self))
        self.entry.bind("<Return>", lambda x: add(x, self))
        self.root.bind("<Control-s>", lambda x: save(x, self))
        # substitute the &lt; with and angular parenthesis

class PackageInstaller:
    def __init__(self, window):
        self.window = window

    def copy_to_config(self):
        if self.window.copy_var.get() == 1:
            messagebox.showinfo("Copy to .config", "Directory copied to .config for faster and easier access.")

    def show_calendar(self):
        cal = Calendar(self.window.root, selectmode="day", year=2023, month=1, day=1, bg='#282828', fg='white')
        cal.pack()

    def update_time(self):
        string = strftime('%H:%M:%S %p')
        self.window.time_label.config(text=string)
        self.window.time_label.after(1000, self.update_time)

# New functions for package list
def add(event, window):
    "add item to listbox with entry when Return is pressed"
    window.lst.insert(tk.END, window.entry.get())
    window.v.set("")
    save("", window)

def delete(event, window):
    "deletes items in listbox with double click on item"
    window.lst.delete(tk.ANCHOR)
    save("", window)

def save(event, window):
    "saves memos in listbox"
    with open("data.txt", "w") as file:
        file.write("\n".join(window.lv.get()))
    window.label["text"] = "Data saved"

def getdata(window):
    "grab saved data"
    if "data.txt" in os.listdir():
        with open("data.txt") as file:
            for line in file:
                window.lst.insert(tk.END, line.strip())

if __name__ == "__main__":
    app_window = Window()
    package_installer = PackageInstaller(app_window)
    app_window.update_time()
    app_window.root.mainloop()
