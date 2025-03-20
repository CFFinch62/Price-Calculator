import sys
print(f"Python executable path: {sys.executable}")
print(f"Python version: {sys.version}")

from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QLabel, 
                            QLineEdit, QPushButton, QVBoxLayout, QHBoxLayout,
                            QMenuBar, QMenu, QMessageBox, QGridLayout,
                            QDialog, QColorDialog)
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QPalette, QColor
import json
import os

class ColorSettingsDialog(QDialog):
    def __init__(self, parent=None, current_colors=None):
        super().__init__(parent)
        self.setWindowTitle("Color Settings")
        self.setMinimumWidth(400)
        
        layout = QVBoxLayout(self)
        
        # Create color picker buttons
        self.color_pickers = {}
        
        color_items = {
            'window_bg': 'Window Background',
            'window_text': 'Window Text',
            'textbox_bg': 'Textbox Background',
            'textbox_text': 'Textbox Text'
        }
        
        # Store default colors
        self.default_colors = {
            'window_bg': '#FFFFFF',
            'window_text': '#000000',
            'textbox_bg': '#FFFFFF',
            'textbox_text': '#000000'
        }
        
        for key, label in color_items.items():
            hbox = QHBoxLayout()
            label_widget = QLabel(f"{label}:")
            button = QPushButton()
            button.setFixedSize(50, 25)
            
            # Set current color if provided
            if current_colors and key in current_colors:
                color = QColor(current_colors[key])
                button.setStyleSheet(f"background-color: {color.name()}")
            
            button.clicked.connect(lambda checked, k=key: self.pick_color(k))
            self.color_pickers[key] = button
            
            hbox.addWidget(label_widget)
            hbox.addWidget(button)
            layout.addLayout(hbox)
        
        # Add buttons
        button_layout = QHBoxLayout()
        
        # Add Reset to Defaults button
        reset_defaults_button = QPushButton("Reset to Defaults")
        reset_defaults_button.clicked.connect(self.reset_to_defaults)
        
        save_button = QPushButton("Save")
        cancel_button = QPushButton("Cancel")
        
        save_button.clicked.connect(self.accept)
        cancel_button.clicked.connect(self.reject)
        
        button_layout.addWidget(reset_defaults_button)
        button_layout.addWidget(save_button)
        button_layout.addWidget(cancel_button)
        layout.addLayout(button_layout)
    
    def pick_color(self, key):
        color = QColorDialog.getColor()
        if color.isValid():
            self.color_pickers[key].setStyleSheet(f"background-color: {color.name()}")
    
    def get_colors(self):
        return {
            key: self.color_pickers[key].palette().button().color().name()
            for key in self.color_pickers
        }

    def reset_to_defaults(self):
        for key, button in self.color_pickers.items():
            button.setStyleSheet(f"background-color: {self.default_colors[key]}")

class PriceCalculator(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Price Calculator")
        self.setMinimumSize(400, 300)
        self.dark_mode = False
        # Store previous colors
        self.previous_colors = None
        
        # Create and store central widget first
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        self.central_widget = central_widget  # Store reference to central widget
        layout = QVBoxLayout(central_widget)
        
        # Create menu bar
        self.create_menu_bar()
        
        # Create input fields
        grid = QGridLayout()
        
        # Dictionary to store input fields
        self.fields = {}
        
        # Create labels and text entries
        items = ['Price', 'Margin', 'Profit', 'Markup', 'Cost']
        for i, item in enumerate(items):
            label = QLabel(f"{item}:")
            label.setStyleSheet("font-weight: bold;")  # Make label text bold
            entry = QLineEdit()
            entry.setPlaceholderText(f"Enter {item.lower()}")
            entry.textChanged.connect(self.clear_error_styling)
            entry.setAlignment(Qt.AlignmentFlag.AlignLeft)
            entry.setStyleSheet("font-weight: bold;")  # Make entry text bold
            self.fields[item.lower()] = entry
            grid.addWidget(label, i, 0)
            grid.addWidget(entry, i, 1)
        
        layout.addLayout(grid)
        
        # Create buttons with swapped positions
        button_layout = QHBoxLayout()
        self.reset_button = QPushButton("Reset")
        self.reset_button.setObjectName("resetButton")  # Set object name for styling
        self.reset_button.setStyleSheet("font-weight: bold;")  # Make button text bold
        
        self.calc_button = QPushButton("Calculate")
        self.calc_button.setObjectName("calcButton")  # Set object name for styling
        self.calc_button.setStyleSheet("font-weight: bold;")  # Make button text bold
        
        self.calc_button.clicked.connect(self.calculate)
        self.reset_button.clicked.connect(self.reset)
        
        button_layout.addWidget(self.reset_button)  # Reset button first
        button_layout.addWidget(self.calc_button)   # Calculate button second
        layout.addLayout(button_layout)

        # Load saved colors after creating all widgets
        self.load_colors()
    
    def create_menu_bar(self):
        menubar = self.menuBar()
        
        # Tools menu
        tools_menu = menubar.addMenu("Tools")
        
        calc_action = tools_menu.addAction("Calculate")
        calc_action.triggered.connect(self.calculate)
        
        reset_action = tools_menu.addAction("Reset")
        reset_action.triggered.connect(self.reset)
        
        tools_menu.addSeparator()
        
        # Add color settings
        color_action = tools_menu.addAction("Color Settings")
        color_action.triggered.connect(self.show_color_settings)
        
        # Add theme switcher
        self.theme_action = tools_menu.addAction("Dark Mode")
        self.theme_action.setCheckable(True)
        self.theme_action.triggered.connect(self.toggle_theme)
        
        tools_menu.addSeparator()
        
        exit_action = tools_menu.addAction("Exit")
        exit_action.triggered.connect(self.close)
        
        # Help menu
        help_menu = menubar.addMenu("Help")
        
        guide_action = help_menu.addAction("User Guide")
        guide_action.triggered.connect(self.show_user_guide)
        
        about_action = help_menu.addAction("About")
        about_action.triggered.connect(self.show_about)
    
    def load_colors(self):
        try:
            if os.path.exists('color_settings.json'):
                with open('color_settings.json', 'r') as f:
                    self.custom_colors = json.load(f)
            else:
                self.custom_colors = {
                    'window_bg': '#FFFFFF',
                    'window_text': '#000000',
                    'textbox_bg': '#FFFFFF',
                    'textbox_text': '#000000'
                }
        except Exception:
            # If there's any error, use defaults
            self.custom_colors = {
                'window_bg': '#FFFFFF',
                'window_text': '#000000',
                'textbox_bg': '#FFFFFF',
                'textbox_text': '#000000'
            }
        self.apply_custom_colors()

    def save_colors(self):
        with open('color_settings.json', 'w') as f:
            json.dump(self.custom_colors, f)

    def show_color_settings(self):
        dialog = ColorSettingsDialog(self, self.custom_colors)
        if dialog.exec() == QDialog.DialogCode.Accepted:
            self.custom_colors = dialog.get_colors()
            self.save_colors()
            self.apply_custom_colors()

    def apply_custom_colors(self):
        # Apply colors to the application
        palette = self.palette()
        palette.setColor(QPalette.ColorRole.Window, QColor(self.custom_colors['window_bg']))
        palette.setColor(QPalette.ColorRole.WindowText, QColor(self.custom_colors['window_text']))
        self.setPalette(palette)
        
        # Update stylesheet for text boxes, labels, window and menu
        main_style = f"""
            QLineEdit {{
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 3px;
                background-color: {self.custom_colors['textbox_bg']};
                color: {self.custom_colors['textbox_text']};
                font-weight: bold;
            }}
            QLabel {{
                font-weight: bold;
                color: {self.custom_colors['window_text']};
            }}
            QWidget#centralWidget {{
                background-color: {self.custom_colors['window_bg']};
            }}
            QMenuBar {{
                background-color: {self.custom_colors['window_bg']};
                color: {self.custom_colors['window_text']};
            }}
            QMenuBar::item:selected {{
                background-color: {QColor(self.custom_colors['window_bg']).lighter(110).name()};
            }}
            QMenu {{
                background-color: {self.custom_colors['window_bg']};
                color: {self.custom_colors['window_text']};
            }}
            QMenu::item:selected {{
                background-color: {QColor(self.custom_colors['window_bg']).lighter(110).name()};
            }}
        """
        
        # Apply styles to central widget and its children
        self.central_widget.setObjectName("centralWidget")
        self.central_widget.setStyleSheet(main_style)
        self.menuBar().setStyleSheet(main_style)
        
        # Set button styles separately
        button_style = """
            QPushButton#calcButton {
                padding: 6px 12px;
                background-color: #4CAF50;  /* Green */
                border: 1px solid #45a049;
                border-radius: 3px;
                color: black;
                font-weight: bold;
            }
            QPushButton#resetButton {
                padding: 6px 12px;
                background-color: #f44336;  /* Red */
                border: 1px solid #da190b;
                border-radius: 3px;
                color: black;
                font-weight: bold;
            }
            QPushButton#calcButton:hover {
                background-color: #45a049;
            }
            QPushButton#resetButton:hover {
                background-color: #da190b;
            }
        """
        self.calc_button.setStyleSheet(button_style)
        self.reset_button.setStyleSheet(button_style)

    def set_dark_mode(self):
        self.dark_mode = True
        self.theme_action.setChecked(True)
        # Store current colors before switching to dark mode
        self.previous_colors = self.custom_colors.copy()
        self.custom_colors = {
            'window_bg': '#353535',
            'window_text': '#FFFFFF',
            'textbox_bg': '#333333',
            'textbox_text': '#FFFFFF'
        }
        self.save_colors()
        self.apply_custom_colors()

    def set_light_mode(self):
        self.dark_mode = False
        self.theme_action.setChecked(False)
        # Restore previous colors if they exist
        if self.previous_colors:
            self.custom_colors = self.previous_colors.copy()
        else:
            self.custom_colors = {
                'window_bg': '#FFFFFF',
                'window_text': '#000000',
                'textbox_bg': '#FFFFFF',
                'textbox_text': '#000000'
            }
        self.save_colors()
        self.apply_custom_colors()

    def toggle_theme(self):
        if self.dark_mode:
            self.set_light_mode()
        else:
            self.set_dark_mode()

    def clear_error_styling(self):
        sender = self.sender()
        sender.setStyleSheet("")
        # Reapply the custom colors without affecting the buttons
        self.apply_custom_colors()
    
    def format_currency(self, value):
        """Format a number as currency with $ and thousands separator"""
        return f"${value:,.2f}"

    def format_percentage(self, value):
        """Format a number as percentage with 2 decimal places"""
        return f"{value:.2f}%"

    def parse_input(self, text):
        """Parse input text by removing $ and % symbols and commas"""
        if not text:
            return None
        # Remove $, %, and commas
        clean_text = text.replace('$', '').replace('%', '').replace(',', '')
        try:
            return float(clean_text)
        except ValueError:
            return None

    def calculate(self):
        # Get values from fields
        values = {}
        filled_fields = []
        
        for field_name, field in self.fields.items():
            try:
                value = self.parse_input(field.text())
                
                # Add margin validation
                if field_name == 'margin' and value is not None:
                    if value > 100:
                        field.setStyleSheet("background-color: #FFE0E0;")
                        QMessageBox.warning(self, "Invalid Input", 
                                          "Margin cannot be greater than 100%")
                        return
                
                values[field_name] = value
                if value is not None:
                    filled_fields.append(field_name)
            except ValueError:
                field.setStyleSheet("background-color: #FFE0E0;")
                QMessageBox.warning(self, "Invalid Input", 
                                  f"Please enter a valid number for {field_name}")
                return
        
        # Check if exactly two fields are filled
        if len(filled_fields) != 2:
            QMessageBox.warning(self, "Input Error", 
                              "Please fill exactly two fields to calculate")
            return
        
        # Check if margin and markup are the only filled fields
        if set(filled_fields) == {'margin', 'markup'}:
            QMessageBox.warning(self, "Invalid Combination", 
                              "Cannot calculate using only margin and markup")
            return
        
        # Perform calculations based on filled fields
        try:
            self.perform_calculations(values, filled_fields)
        except ValueError as e:
            QMessageBox.warning(self, "Calculation Error", str(e))
    
    def perform_calculations(self, values, filled_fields):
        price = values['price']
        cost = values['cost']
        margin = values['margin']
        markup = values['markup']
        profit = values['profit']
        
        # Calculate based on which fields are filled
        if 'price' in filled_fields and 'cost' in filled_fields:
            profit = price - cost
            margin = (profit / price) * 100
            markup = (profit / cost) * 100
        
        elif 'price' in filled_fields and 'margin' in filled_fields:
            profit = price * (margin / 100)
            cost = price - profit
            markup = (profit / cost) * 100
        
        elif 'price' in filled_fields and 'markup' in filled_fields:
            cost = price / (1 + markup / 100)
            profit = price - cost
            margin = (profit / price) * 100
        
        elif 'cost' in filled_fields and 'margin' in filled_fields:
            profit = (cost * margin) / (100 - margin)
            price = cost + profit
            markup = (profit / cost) * 100
        
        elif 'cost' in filled_fields and 'markup' in filled_fields:
            profit = cost * (markup / 100)
            price = cost + profit
            margin = (profit / price) * 100
        
        # Update all fields with formatted values
        self.fields['price'].setText(self.format_currency(price))
        self.fields['cost'].setText(self.format_currency(cost))
        self.fields['margin'].setText(self.format_percentage(margin))
        self.fields['markup'].setText(self.format_percentage(markup))
        self.fields['profit'].setText(self.format_currency(profit))
    
    def reset(self):
        for field in self.fields.values():
            field.clear()
            field.setStyleSheet("")
    
    def show_user_guide(self):
        guide_text = """
        User Guide:
        
        1. Enter values in any two fields (except margin and markup together)
        2. Click Calculate to compute all other values
        3. You can adjust any value and recalculate
        4. Use Reset to clear all fields
        
        Definitions:
        - Price: Selling price
        - Cost: Cost of goods
        - Margin: (Profit / Price) × 100
        - Markup: (Profit / Cost) × 100
        - Profit: Price - Cost
        """
        QMessageBox.information(self, "User Guide", guide_text)
    
    def show_about(self):
        about_text = """
        Price Calculator v1.0
        
        A simple tool to calculate price, cost, margin,
        markup, and profit relationships.
        
        Created with PyQt6
        """
        QMessageBox.information(self, "About", about_text)

def main():
    app = QApplication(sys.argv)
    calculator = PriceCalculator()
    calculator.show()
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
