using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EmployeeInfoApp
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        string connectionString =
               ConfigurationManager.ConnectionStrings["EmployeeInfoConString"].ConnectionString;

        private bool isUpdateMode = false;

        private int employeeId;

        private void saveButton_Click(object sender, EventArgs e)
        {
            string name = nameTextBox.Text;
            string email = emailTextBox.Text;
            string address = addressTextBox.Text;
            int salary = Convert.ToInt32(salaryTextBox.Text);

            if (isUpdateMode)
            {
                //1. connect to database - i.e. server, database, authentication (connectionstring)

                SqlConnection connection = new SqlConnection(connectionString);

                //2. write query

                string query = "UPDATE tbl_employee SET name='" + name + "',address = '" + address + "',salary = '" +
                               salary +
                               "' WHERE id = '" + employeeId + "'";

                //3. execute query

                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                int rowAffected = command.ExecuteNonQuery();
                connection.Close();


                //4. see result

                if (rowAffected > 0)
                {
                    MessageBox.Show("Update Successfully!");

                    saveButton.Text = "Save";
                    employeeId = 0;
                    isUpdateMode = false;

                    ShowAllEmployees();
                }
                else
                {
                    MessageBox.Show("Update Failed!");
                }
            }
            else
            {
                // Is email Exists? if exists not insert, else insert

                if (IsEmailExists(email))
                {
                    MessageBox.Show("Email already exists !");
                }
                else
                {
                    //1. connect to database - i.e. server, database, authentication (connectionstring)

                    SqlConnection connection = new SqlConnection(connectionString);

                    //2. write query

                    string query = "INSERT INTO tbl_employee VALUES('" + name + "','" + email + "','" + address + "','" +
                                   salary +
                                   "')";

                    //3. execute query

                    SqlCommand command = new SqlCommand(query, connection);

                    connection.Open();
                    int rowAffected = command.ExecuteNonQuery();
                    connection.Close();


                    //4. see result

                    if (rowAffected > 0)
                    {
                        MessageBox.Show("Inserted Successfully!");
                        ShowAllEmployees();
                    }
                    else
                    {
                        MessageBox.Show("Insertion Failed!");
                    }
                }
                
            }

        }

        public bool IsEmailExists(string email)
        {
            
            SqlConnection connection = new SqlConnection(connectionString);

            //2. write query
              
            string query = "SELECT * FROM tbl_employee WHERE email = '"+email+"'";

            //3. execute query

            SqlCommand command = new SqlCommand(query, connection);

            bool isEmailExists = false;
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                isEmailExists = true;
                break;
            }
            reader.Close();
            connection.Close();

            return isEmailExists;
        }

        private void showButton_Click(object sender, EventArgs e)
        {
            ShowAllEmployees();
            
        }

        public void LoadEmployeeListView(List<Employee> employees)
        {
            employeeListView.Items.Clear();
            foreach (var employee in employees)
            {
                ListViewItem item = new ListViewItem(employee.id.ToString());
                item.SubItems.Add(employee.name);
                item.SubItems.Add(employee.email);
                item.SubItems.Add(employee.address);
                item.SubItems.Add(employee.salary.ToString());

                employeeListView.Items.Add(item);
            }
            
        }

        public void ShowAllEmployees()
        {
            SqlConnection connection = new SqlConnection(connectionString);

            //2. write query

            string query = "SELECT * FROM tbl_employee";

            //3. execute query

            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            List<Employee> employeeList = new List<Employee>();

            while (reader.Read())
            {
                Employee employees = new Employee();

                employees.id = int.Parse(reader["id"].ToString());
                employees.name = reader["name"].ToString();
                employees.email = reader["email"].ToString();
                employees.address = reader["address"].ToString();
                employees.salary = int.Parse(reader["salary"].ToString());

                employeeList.Add(employees);

            }
            reader.Close();
            connection.Close();

            //populate list view with data

            LoadEmployeeListView(employeeList); 
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            ShowAllEmployees();
        }

 
        private void employeeListView_DoubleClick(object sender, EventArgs e)
        {
            // 1.Select selected Employee

            ListViewItem item = employeeListView.SelectedItems[0];

            int id = int.Parse(item.Text.ToString());

            Employee employee = GetEmaployeeByID(id);

            if (employee != null)
            {
                //2. Enableupdate mode -- save button = update button, grab id

                isUpdateMode = true;

                saveButton.Text = "Update";

                employeeId = employee.id;

                //3. Fill Text with employee data

                nameTextBox.Text = employee.name;
                emailTextBox.Text = employee.email;
                addressTextBox.Text = employee.address;
                salaryTextBox.Text = employee.salary.ToString();

            }


            

        }

        public Employee GetEmaployeeByID(int id)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            //2. write query

            string query = "SELECT * FROM tbl_employee WHERE id = '"+id+"'";

            //3. execute query
              
            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            List<Employee> employeeList = new List<Employee>();

            while (reader.Read())
            {
                Employee employees = new Employee();

                employees.id = int.Parse(reader["id"].ToString());
                employees.name = reader["name"].ToString();
                employees.email = reader["email"].ToString();
                employees.address = reader["address"].ToString();
                employees.salary = int.Parse(reader["salary"].ToString());

                employeeList.Add(employees);

            }
            reader.Close();
            connection.Close();

            return employeeList.FirstOrDefault();

        }

        
    }
    
}
