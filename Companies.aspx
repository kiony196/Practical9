
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Companies.aspx.cs"
    Inherits="Practical9.Companies" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Company Summary</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f6fa;
            margin: 0;
            padding: 25px;
            color: #243447;
        }

        .container {
            max-width: 1150px;
            margin: auto;
        }

        h1, h2 {
            color: #17365D;
        }

        .section {
            margin-top: 25px;
        }

        .placement-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin-top: 15px;
        }

        .placement-table th,
        .placement-table td {
            border: 1px solid #d5dce5;
            padding: 12px;
            text-align: left;
        }

        .placement-table th {
            background: #17365D;
            color: white;
        }

        .placement-table tr:nth-child(even) {
            background: #f2f5f9;
        }

        .company-list {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
            margin-top: 15px;
        }

        .company-card {
            width: 260px;
            max-width: 100%;
            box-sizing: border-box;
            background: white;
            border: 1px solid #d5dce5;
            border-radius: 8px;
            padding: 18px;
            box-shadow: 0 2px 6px #ddd;
        }

        .company-card h3 {
            color: #17365D;
            margin-top: 0;
        }

        .company-card p {
            margin: 10px 0;
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            padding: 11px 18px;
            background: #17365D;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .back-link:hover {
            background: #24558a;
        }

        .message {
            display: block;
            margin-top: 15px;
            color: #b42318;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="container">

            <h1>Company Summary</h1>

            <!-- PLACEMENT RECORDS -->
            <div class="section">

                <h2>Student Placement Records</h2>

                <asp:Repeater ID="rptPlacements"
                    runat="server">

                    <HeaderTemplate>
                        <table class="placement-table">
                            <tr>
                                <th>Placement ID</th>
                                <th>Student ID</th>
                                <th>Student Name</th>
                                <th>Company</th>
                                <th>Job Role</th>
                                <th>Package (LPA)</th>
                            </tr>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Eval("PlacementId") %>
                            </td>

                            <td>
                                <%# Eval("StudentId") %>
                            </td>

                            <td>
                                <%# Eval("StudentName") %>
                            </td>

                            <td>
                                <%# Eval("CompanyName") %>
                            </td>

                            <td>
                                <%# Eval("JobRole") %>
                            </td>

                            <td>
                                <%# Eval("PackageLPA", "{0:F2}") %>
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                        </table>
                    </FooterTemplate>

                </asp:Repeater>

            </div>

            <!-- COMPANY DETAILS -->
            <div class="section">

                <h2>Company Details</h2>

                <div class="company-list">

                    <asp:DataList ID="dlCompanies"
                        runat="server"
                        RepeatDirection="Horizontal"
                        RepeatLayout="Flow">

                        <ItemTemplate>

                            <div class="company-card">

                                <h3>
                                    <%# Eval("CompanyName") %>
                                </h3>

                                <p>
                                    <b>Job Role:</b>
                                    <%# Eval("JobRole") %>
                                </p>

                                <p>
                                    <b>Package (LPA):</b>
                                    <%# Eval("PackageLPA", "{0:F2}") %>
                                </p>

                            </div>

                        </ItemTemplate>

                    </asp:DataList>

                </div>

            </div>

            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

            <br />

            <asp:HyperLink ID="lnkBack"
                runat="server"
                NavigateUrl="~/Default.aspx"
                CssClass="back-link"
                Text="Back to Placement Dashboard" />

        </div>

    </form>
</body>
</html>
