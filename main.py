from PyQt6.QtWidgets import *
from PyQt6 import uic
import pyodbc
global connection,cursor
class MyGUI(QMainWindow):
    def __init__(self):
        super(MyGUI,self).__init__()
        uic.loadUi("gui.ui",self)
        self.show()
        self.pushButton.clicked.connect(self.getTopRated)
        self.pushButton_2.clicked.connect(self.getTitles)
        self.pushButton_3.clicked.connect(self.getCommonTitles)
        self.pushButton_4.clicked.connect(self.getColleagues)
    
    def getTopRated(self):
        global connection,cursor
        type='tvseries'
        if self.radioButton.isChecked():
            type='movie'
        cursor=connection.cursor()
        cursor.execute(f"select * from dbo.TopRated('{type}')")
        data=cursor.fetchall()
        cursor.close()
        self.tableWidget.setRowCount(0)
        for row_number,row_data in enumerate(data):
            self.tableWidget.insertRow(row_number)
            for column_number,cell in enumerate(row_data):
                self.tableWidget.setItem(row_number,column_number,QTableWidgetItem(str(cell)))
    
    def getCommonTitles(self):
        global connection,cursor
        name1=self.lineEdit_2.text()
        name2=self.lineEdit_3.text()
        cursor=connection.cursor()
        cursor.execute(f"select * from dbo.commonTitles('{name1}','{name2}')")
        data=cursor.fetchall()
        cursor.close()
        self.tableWidget_3.setRowCount(0)
        for row_number,row_data in enumerate(data):
            self.tableWidget_3.insertRow(row_number)
            for column_number,cell in enumerate(row_data):
                self.tableWidget_3.setItem(row_number,column_number,QTableWidgetItem(str(cell)))

    
    def getTitles(self):
        global connection,cursor
        type='movie'
        if self.radioButton_4.isChecked():
            type='tvseries'
        elif self.radioButton_5.isChecked():
            type='all'
        name=self.lineEdit.text()
        cursor=connection.cursor()
        cursor.execute(f"select * from dbo.titlesByActor('{name}','{type}')")
        data=cursor.fetchall()
        cursor.close()
        self.tableWidget_2.setRowCount(0)
        for row_number,row_data in enumerate(data):
            self.tableWidget_2.insertRow(row_number)
            for column_number,cell in enumerate(row_data):
                self.tableWidget_2.setItem(row_number,column_number,QTableWidgetItem(str(cell)))
        

    def getColleagues(self):
        global cursor,connection
        name=self.lineEdit_4.text()
        cursor=connection.cursor()
        cursor.execute(f"select * from dbo.colleagues('{name}')")
        data=cursor.fetchall()
        cursor.close()
        self.tableWidget_4.setRowCount(0)
        for row_number,row_data in enumerate(data):
            self.tableWidget_4.insertRow(row_number)
            for column_number,cell in enumerate(row_data):
                self.tableWidget_4.setItem(row_number,column_number,QTableWidgetItem(str(cell)))
        
def main():
    global connection,cursor
    connection_string = f'DRIVER={{SQL Server}};SERVER=DESKTOP-KJP8BQF\SQLEXPRESS;DATABASE=master;Trusted_Connection=yes;'
    connection=pyodbc.connect(connection_string)
    app=QApplication([])
    window=MyGUI()
    app.exec()
    connection.close()


if __name__=="__main__":
    main()





