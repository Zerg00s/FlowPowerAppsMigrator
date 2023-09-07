enum ControlType {
    RadioButtons = 1
    ComboBox = 2
}

<#
.DESCRIPTION
    Capture user's input by presenting the choices as a group of radio buttons.
.EXAMPLE
    PS C:\> Get-FormArrayItem -items $(get-childitem) -key name -dialogTitle "Select file" -ControlType RadioButtons
.EXAMPLE
    PS C:\> Get-FormArrayItem -items $(get-childitem) -key name -dialogTitle "Select file" -ControlType ComboBox
.EXAMPLE
    PS C:\> $subscription = Get-FormArrayItem -items $accounts -key "name" -dialogTitle "Choose subscription"
    Display the list items. In this case it's an array of of Azure subscriptions.
.EXAMPLE
    PS C:\> $location =  Get-FormArrayItem -items $locations -key "displayName" -dialogTitle "Choose location" -defaultValue "Canada Central"
    Display a form with the list of Azure Locations where "Canada Central" is selected by default.
.PARAMETER items
    An array of objects
.PARAMETER key
    Name of the property that will serve as a unique key for the radio buttons. This property will also be used to render text beside each radio button.
.PARAMETER dialogTitle
    Descriptive Title of the dialog box.
.OUTPUTS
    Returns an array item (proper object) that was selected via the form by clicking a radio button.
#>
function Get-FormArrayItem {
    Param(
        [Parameter(Mandatory = $true)] $items,
        [Parameter(Mandatory = $false)] $key,
        [Parameter(Mandatory = $false)] $dialogTitle,
        [Parameter()] $defaultValue ,
        [ControlType]
        [Parameter(Mandatory = $false)] $ControlType = [ControlType]::RadioButtons
    )
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

    if ($items.Count -eq 0) {
        Write-Host "'$dialogTitle' dialog did not contain any items. Returning `$null"
        return $null
    }

    if($key -eq $null){
        $key = "Name"
    }

    if($dialogTitle -eq $null){
        $dialogTitle = "Choose one:"
    }

    #-----------------------------------------------------------------------
    # Create a group that will contain your radio buttons
    #-----------------------------------------------------------------------
    $TitleLabel = New-Object System.Windows.Forms.Label
    $TitleLabel.Location = '40,5'
    $TitleLabel.Text = $dialogTitle
    $Font = New-Object System.Drawing.Font("Times New Roman", 13)
    $TitleLabel.Font = $Font 
    $TitleLabel.Width = 550

    $Panel = New-Object System.Windows.Forms.Panel
    $Panel.Location = '40,30'
    $Panel.size = '600,1'
    $Panel.text = $dialogTitle

    $inputControlY = 10
    $radioButtonHeight = 20
    $spaceBetweenControls = $radioButtonHeight + 10
    $Panel.Height = $spaceBetweenControls + 20
    $MaximumPanelHeight = 290
    $RadioFont = New-Object System.Drawing.Font("Times New Roman", 12)

    $OKButton = New-Object System.Windows.Forms.Button
    
     
    if($ControlType -eq [ControlType]::RadioButtons){
        #-----------------------------------------------------------------------
        # Create the collection of radio buttons
        #-----------------------------------------------------------------------
        foreach ($item in $items) {
            $RadioButton = New-Object System.Windows.Forms.RadioButton
            $RadioButton.Location = "20,$inputControlY"
            $RadioButton.size = "550,$radioButtonHeight" 
            $RadioButton.Font = $RadioFont

            $props = Get-Member -InputObject $item -MemberType NoteProperty
        
            $prop = $props | Where-Object { $_.name -eq $key }
            $propValue = $item | Select-Object -ExpandProperty $prop.Name
            $RadioButton.Text = $propValue
            if ($RadioButton.Text -eq $defaultValue) {
                $RadioButton.Checked = $true 
            }
            else {
                $RadioButton.Checked = $false 
            }
            $Panel.Controls.AddRange($RadioButton)
            $inputControlY += $spaceBetweenControls

            if ($Panel.Height -lt $MaximumPanelHeight) {
                $Panel.Height += $spaceBetweenControls    
            }else{
                $Panel.BorderStyle = 1
                $Panel.VerticalScroll.Enabled = $true;
                $Panel.VerticalScroll.Visible = $true;
                $Panel.AutoScroll = $true;
            }
        }    
      
     }

    if($ControlType -eq [ControlType]::ComboBox){
        #-----------------------------------------------------------------------
        # Add Combobox with autocomplete
        #-----------------------------------------------------------------------
        $ComboBox                       = New-Object system.Windows.Forms.ComboBox
        $ComboBox.text                  = "comboBox"
        $ComboBox.width                 = 580
        $ComboBox.height                = 50
        $ComboBox.Location              = New-Object System.Drawing.Point(10,20)
        $ComboBox.Font                  = 'Times New Roman,12'

        ##############   DropDown #################

        $ComboBox.DropDownStyle  = [System.Windows.Forms.ComboBoxStyle]::DropDown;                      
        foreach($item in $items){
            $ComboBox.Items.add($item) | Out-Null
        }
        $ComboBox.SelectedIndex = 1        
  
        ##############   AutoComplite #################

        $ComboBox.AutoCompleteSource      ='CustomSource'
        $ComboBox.AutoCompleteMode        ='SuggestAppend'
        foreach($item in $items){$ComboBox.AutoCompleteCustomSource.AddRange($item)}
        $choice = $ComboBox.Text

        ######## If Combobox text is different from list or null ###############

        $ComboBox.add_TextChanged({Combobox})
        $Panel.Controls.Add($ComboBox)
        $Panel.Height += $spaceBetweenControls    

        function Combobox{
            if ($null -eq $ComboBox.SelectedItem){
                $OKButton.Enabled = $false
            }else{
                $OKButton.Enabled = $true
            }
        }
    }


    #-----------------------------------------------------------------------
    # Add an OK button
    #-----------------------------------------------------------------------
    $ActionButtonHeight = 40
    $ActionButtonY = $Panel.size.Height + $Panel.Location.Y + 10
    # $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = "130,$ActionButtonY"
    $OKButton.Size = "100,$ActionButtonHeight" 
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
 
    #-----------------------------------------------------------------------
    #Add a cancel button
    #-----------------------------------------------------------------------
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = "255,$ActionButtonY"
    $CancelButton.Size = "100,$ActionButtonHeight"
    $CancelButton.Text = "Cancel"
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

    $Form = New-Object System.Windows.Forms.Form
    $Form.width = $Panel.size.Width + 80
    $Form.height = $OKButton.Location.Y + $OKButton.Height + 60
    $Form.Text = $dialogTitle
    $Form.Topmost = $true
    $Form.StartPosition = "CenterScreen"
 
    #-----------------------------------------------------------------------
    # Set the font of the text to be used within the form
    #-----------------------------------------------------------------------
    $Font = New-Object System.Drawing.Font("Times New Roman", 10)
    $Form.Font = $Font 
    
    $form.Controls.AddRange(@($TitleLabel, $Panel, $OKButton, $CancelButton))
    
    #-----------------------------------------------------------------------
    # Assign the Accept and Cancel options in the form to the corresponding buttons
    #-----------------------------------------------------------------------
    $form.AcceptButton = $OKButton
    $form.CancelButton = $CancelButton
 
    #-----------------------------------------------------------------------
    # Activate the form
    #-----------------------------------------------------------------------
    $form.Add_Shown( { $form.Activate() })
       
    $dialogResult = $form.ShowDialog()
    
 
    #-----------------------------------------------------------------------
    # Get the results of the dialog
    #-----------------------------------------------------------------------
    if ($dialogResult -eq "OK") { 

        if($ControlType -eq [ControlType]::RadioButtons){
            $checkedControl = $Panel.Controls | Where-Object { ([System.Windows.Forms.RadioButton]$_).Checked -eq $true }
            $selectedValue = $checkedControl.Text
        }

        if($ControlType -eq [ControlType]::ComboBox){
             $selectedValue = $ComboBox.Text
        }


        return $items | Where-Object {                  
            $propValue = $_ | Select-Object -ExpandProperty $prop.Name
            $propValue.ToString() -eq $selectedValue
        }
        Write-Host $selectedValue
    }
    else {
        throw "Execution was cancelled by the user"
    }
}


<#
.DESCRIPTION
    Capture user's input by presenting the choices as a group of radio buttons.
.EXAMPLE
    PS C:\> Get-FormArrayItems -items $(get-childitem) -key name -dialogTitle "Select files" 
.PARAMETER items
    An array of objects
.PARAMETER key
    Name of the property that will serve as a unique key for the radio buttons. This property will also be used to render text beside each radio button.
.PARAMETER dialogTitle
    Descriptive Title of the dialog box.
.OUTPUTS
    Returns an array item (proper object) that was selected via the form by clicking a radio button.
#>
function Get-FormArrayItems {
    Param(
        [Parameter(Mandatory = $true)] $items,
        [Parameter(Mandatory = $false)] $key,
        [Parameter(Mandatory = $false)] $dialogTitle
    )
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

    if ($items.Count -eq 0) {
        Write-Host "'$dialogTitle' dialog did not contain any items. Returning `$null"
        return $null
    }

    if($key -eq $null){
        $key = "Name"
    }

    if($dialogTitle -eq $null){
        $dialogTitle = "Choose one:"
    }

    #-----------------------------------------------------------------------
    # Create a group that will contain your radio buttons
    #-----------------------------------------------------------------------
    $TitleLabel = New-Object System.Windows.Forms.Label
    $TitleLabel.Location = '40,5'
    $TitleLabel.Text = $dialogTitle
    $Font = New-Object System.Drawing.Font("Times New Roman", 13)
    $TitleLabel.Font = $Font 
    $TitleLabel.Width = 550

    $Panel = New-Object System.Windows.Forms.Panel
    $Panel.Location = '40,30'
    $Panel.size = '600,1'
    $Panel.text = $dialogTitle

    $inputControlY = 10
    $radioButtonHeight = 20
    $spaceBetweenControls = $radioButtonHeight + 10
    $Panel.Height = $spaceBetweenControls + 20
    $MaximumPanelHeight = 290
    $RadioFont = New-Object System.Drawing.Font("Times New Roman", 12)

    $OKButton = New-Object System.Windows.Forms.Button
    
     
    #-----------------------------------------------------------------------
    # Create the collection of radio buttons
    #-----------------------------------------------------------------------
    foreach ($item in $items) {
        $CheckBox = New-Object System.Windows.Forms.CheckBox
        $CheckBox.Location = "20,$inputControlY"
        $CheckBox.size = "370,$radioButtonHeight" 
        $CheckBox.Font = $RadioFont

        $props = Get-Member -InputObject $item -MemberType Property
        
        $prop = $props | Where-Object { $_.name -eq $key }
        $propValue = $item | Select-Object -ExpandProperty $prop.Name
        $CheckBox.Text = $propValue
        if ($CheckBox.Text -eq $defaultValue) {
            $CheckBox.Checked = $true 
        }
        else {
            $CheckBox.Checked = $false 
        }
        $Panel.Controls.AddRange($CheckBox)
        $inputControlY += $spaceBetweenControls

        if ($Panel.Height -lt $MaximumPanelHeight) {
            $Panel.Height += $spaceBetweenControls    
        }else{
            $Panel.BorderStyle = 1
            $Panel.VerticalScroll.Enabled = $true;
            $Panel.VerticalScroll.Visible = $true;
            $Panel.AutoScroll = $true;
        }
    }    
      

    #-----------------------------------------------------------------------
    # Add an OK button
    #-----------------------------------------------------------------------
    $ActionButtonHeight = 40
    $ActionButtonY = $Panel.size.Height + $Panel.Location.Y + 10
    # $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = "130,$ActionButtonY"
    $OKButton.Size = "100,$ActionButtonHeight" 
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
 
    #-----------------------------------------------------------------------
    #Add a cancel button
    #-----------------------------------------------------------------------
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = "255,$ActionButtonY"
    $CancelButton.Size = "100,$ActionButtonHeight"
    $CancelButton.Text = "Cancel"
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

    $Form = New-Object System.Windows.Forms.Form
    $Form.width = $Panel.size.Width + 80
    $Form.height = $OKButton.Location.Y + $OKButton.Height + 60
    $Form.Text = $dialogTitle
    $Form.Topmost = $true
    $Form.StartPosition = "CenterScreen"
 
    #-----------------------------------------------------------------------
    # Set the font of the text to be used within the form
    #-----------------------------------------------------------------------
    $Font = New-Object System.Drawing.Font("Times New Roman", 10)
    $Form.Font = $Font 
    
    $form.Controls.AddRange(@($TitleLabel, $Panel, $OKButton, $CancelButton))
    
    #-----------------------------------------------------------------------
    # Assign the Accept and Cancel options in the form to the corresponding buttons
    #-----------------------------------------------------------------------
    $form.AcceptButton = $OKButton
    $form.CancelButton = $CancelButton
 
    #-----------------------------------------------------------------------
    # Activate the form
    #-----------------------------------------------------------------------
    $form.Add_Shown( { $form.Activate() })
       
    $dialogResult = $form.ShowDialog()
    
 
    #-----------------------------------------------------------------------
    # Get the results of the dialog
    #-----------------------------------------------------------------------
    if ($dialogResult -eq "OK") { 

        $checkedControls = $Panel.Controls | Where-Object { ([System.Windows.Forms.CheckBox]$_).Checked -eq $true }
        $checkedKeys = $checkedControls | % {$_.Text }     
        
         return $items | Where-Object {                  
             $propValue = $_ | Select-Object -ExpandProperty $prop.Name             
             $checkedKeys.contains($propValue.ToString())
         }
        Write-Host $selectedValue
    }
    else {
        throw "Execution was cancelled by the user"
    }
}


<#
.DESCRIPTION
    Simple Dialog box that returns $true if user clicks "Yes" and $false if "No" is clicked. 
    Useful if you want to make your script interactive and user-friendly.
.EXAMPLE
    PS C:\> $createNewResourceGroup = Get-FormBinaryAnswer "Do you want to create a new Resource Group?"
    Displays a dialog box with Yes and No buttons.
.INPUTS
    dialogTitle
.OUTPUTS
    $true or $false
#>
function Get-FormBinaryAnswer {
    Param(
        [Parameter(Position = 0)] $dialogTitle
    )

    $options = @([pscustomobject]@{Value = $true; Name = "Yes" }, [pscustomobject]@{Value = $false; Name = "No" })
    $answer = Get-FormArrayItem -items $options -key "Name" -dialogTitle $dialogTitle
    return $answer.Value
}

<#
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> $UserName = Get-FormStringInput "Enter your name" 
    Shows a dialog with an input box with OK and Cancel buttons.
.EXAMPLE
    PS C:\> $resourceGroupName = Get-FormStringInput "Enter new resource group name" -defaultValue "Comments-Notification"
    Shows a dialog with an input where "Comments-Notification" is pre-populated.
.OUTPUTS
    returns a string that user typed in an input box.
#>
function Get-FormStringInput {
    Param(
        [Parameter(Mandatory = $true, Position = 0)] $dialogTitle,
        [Parameter(Position = 1)] $defaultValue 
    )

    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")     

    $label = New-Object System.Windows.Forms.Label
    $label.size = "600,50"
    $label.Location = New-Object System.Drawing.Point(10, 10)
    $label.Text = $dialogTitle
    $Font = New-Object System.Drawing.Font("Times New Roman", 12)
    $label.Font = $Font

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.size = "600,50"
    $textBox.Location = New-Object System.Drawing.Point(10, 60)
    $Font = New-Object System.Drawing.Font("Times New Roman", 15)
    $textBox.Font = $Font
    $textBox.Text = $defaultValue

    #-----------------------------------------------------------------------
    # Add an OK button
    #-----------------------------------------------------------------------
    $ActionButtonHeight = 40
    $ActionButtonY = 140
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = "130,$ActionButtonY"
    $OKButton.Size = "100,$ActionButtonHeight" 
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
 
    #-----------------------------------------------------------------------
    # Add an cancel button
    #----------------------------------------------------------------------
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = "255,$ActionButtonY"
    $CancelButton.Size = "100,$ActionButtonHeight"
    $CancelButton.Text = "Cancel"
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

    $Form = New-Object System.Windows.Forms.Form
    $Form.width = $textBox.size.Width + 50
    $Form.height = $OKButton.Location.Y + $OKButton.Height + 80
    $Form.Text = $dialogTitle
    $Form.Topmost = $true
    $Form.StartPosition = "CenterScreen"
 
    #-----------------------------------------------------------------------
    # Set the font of the text to be used within the form
    #-----------------------------------------------------------------------
    $Font = New-Object System.Drawing.Font("Times New Roman", 10)
    $Form.Font = $Font
 
    #-----------------------------------------------------------------------
    # Add all the Form controls on one line 
    #-----------------------------------------------------------------------
    $form.Controls.AddRange(@($label, $textBox, $OKButton, $CancelButton))
    
    # Assign the Accept and Cancel options in the form to the corresponding buttons
    $form.AcceptButton = $OKButton
    $form.CancelButton = $CancelButton
 
    #-----------------------------------------------------------------------
    # Activate the form
    #-----------------------------------------------------------------------
    $form.Add_Shown( { $form.Activate() })    
    
    #-----------------------------------------------------------------------
    # Get the results from the button click
    #-----------------------------------------------------------------------
    $dialogResult = $form.ShowDialog()
 
    #-----------------------------------------------------------------------
    # If the OK button is selected
    #-----------------------------------------------------------------------
    if ($dialogResult -eq "OK") {
        return $textBox.Text   
        
    }
    else {
        throw "Execution was cencelled by the user"
    }
}


<#
.DESCRIPTION
    Displays the dynamic form that renders one text box for every object's property. 
    When user populates the form and clicks OK - returned object contains property values from the form's inputs
.EXAMPLE
    PS C:\> $preDeployInputs = @{
        suffix     = ""
        TimeZone = "Central Standard Time"
        sendGridRegistrationEmail = "ENTER_VALID_EMAIL_ADDRESS"
        fromEmail = "no-reply@DOMAIN.COM"
    }
    PS C:\> $preDeployInputs = Get-FormItemProperties -item $preDeployInputs -dialogTitle "Fill these required fields"
    Displays the form that has 4 text inputs. When user populates them and clicks OK - returned object contains property values from the form's inputs
.INPUTS
    PSCustomObject or a Hashtable
.OUTPUTS
    Returns the same object that was passed in, but with properties populated via the Form that was displayed
#>
function Get-FormItemProperties {
    Param(
        [Parameter(Mandatory = $true)] $item,
        [Parameter(Mandatory = $false)] $dialogTitle,
        [Parameter(Mandatory = $false)] $propertiesOrder,
        [Parameter(Mandatory = $false)] $base64FormIcon,
        [Parameter(Mandatory = $false)] $note
    )
    
    if ($item -eq $null) {
        exit
    }
    
    #-----------------------------------------------------------------------
    # Convert the object to hashtable
    #-----------------------------------------------------------------------
    if ($item.GetType().Name -eq "PSCustomObject") {
        $hashTable = @{ }
        $item.psobject.properties | ForEach-Object { $hashTable[$_.Name] = $_.Value }
        $item = $hashTable
    }
    
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
    
    if ($dialogTitle -eq $null) {
        $dialogTitle = "Fill out values:"
    }
    
    #-----------------------------------------------------------------------
    # Create a group that will contain textboxes
    #-----------------------------------------------------------------------
    $Panel = New-Object System.Windows.Forms.Panel
    $Panel.DockPadding.Bottom = 40
    $Panel.Dock = [System.Windows.Forms.DockStyle]::Fill
        
    $Font = New-Object System.Drawing.Font("Times New Roman", 12)
    
    $textboxY = 40
    $textboxHeight = 20
    $spaceBetweenTextboxes = $textboxHeight + 22
    
    $textboxes = @()
    foreach ($key in $propertiesOrder) {
    
        $Label = New-Object System.Windows.Forms.Label
        $Label.Location = "20,$textboxY"
        $Label.size = "450,$textboxHeight" 
        $Label.Text = $key
    
        $textboxY += $spaceBetweenTextboxes / 2
    
        $TextBox = New-Object System.Windows.Forms.TextBox
        $TextBox.Location = "20,$textboxY"
        $TextBox.size = "450,$textboxHeight"  
            
        $TextBox.Text = $item[$key]
        $Panel.Controls.AddRange(@($Label, $TextBox))
        $textboxes += $TextBox
        $textboxY += $spaceBetweenTextboxes
        $TextBox.Font = $Font
    }
    
    $Panel.BorderStyle = 1
    $Panel.VerticalScroll.Enabled = $true;
    $Panel.VerticalScroll.Visible = $true;
    $Panel.AutoScroll = $true;
    
    
    $Form = New-Object System.Windows.Forms.Form
    $Form.Height = 450
    $Form.Width = 530
    $Form.Text = $dialogTitle
    $Form.Topmost = $true
    $Form.StartPosition = "CenterScreen"
    
    # Base 64 encoded image
    if ($base64FormIcon) {
        $iconBase64 = $base64FormIcon 
        $iconBytes = [Convert]::FromBase64String($iconBase64)
        $stream = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
        $stream.Write($iconBytes, 0, $iconBytes.Length);
        $iconImage = [System.Drawing.Image]::FromStream($stream, $true)
        $Form.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())
    }

    #-----------------------------------------------------------------------
    # Add a note
    #-----------------------------------------------------------------------
    if ($note){
        $NoteLabel = New-Object System.Windows.Forms.Label
        $NoteLabel.Location = "20,$textboxY"
        $NoteLabel.size = "450,$textboxHeight" 
        $NoteLabel.Font = 'Times New Roman,13'
        $NoteLabel.Text = $note
        $textboxY += $spaceBetweenTextboxes/2
        $Panel.Controls.AddRange(@($NoteLabel))
    }

    
    #-----------------------------------------------------------------------
    # Add an OK button
    #-----------------------------------------------------------------------
    $ActionButtonHeight = 40
    $ActionButtonY = $GroupBox.size.Height + $GroupBox.Location.Y + 10
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Size = "100,$ActionButtonHeight" 
    $textboxY+= 30
    $OKButton.Location = "20,$textboxY"
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
 
    #-----------------------------------------------------------------------
    # Add an Cancel button
    #-----------------------------------------------------------------------
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = "370,$textboxY"
    $CancelButton.Size = "100,$ActionButtonHeight"
    $CancelButton.Text = "Cancel"
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel


     
    #-----------------------------------------------------------------------
    # Set the font of the text to be used within the form
    #-----------------------------------------------------------------------
    $Font = New-Object System.Drawing.Font("Times New Roman", 10)
    $Form.Font = $Font
        
    $form.Controls.AddRange(@($Panel))
    
    $Panel.Controls.AddRange(@($OKButton, $CancelButton))
    
    #-----------------------------------------------------------------------
    # Assign the Accept and Cancel options in the form to the corresponding buttons
    #-----------------------------------------------------------------------
    $form.AcceptButton = $OKButton
    $form.CancelButton = $CancelButton

        
    #-----------------------------------------------------------------------
    # Activate the form
    #-----------------------------------------------------------------------
    $form.Add_Shown( { $form.Activate() })   
    #-----------------------------------------------------------------------
    # Get the results from the button click
    #-----------------------------------------------------------------------
    $dialogResult = $form.ShowDialog() 
        
    #-----------------------------------------------------------------------
    # If the OK button is selected
    #-----------------------------------------------------------------------
    if ($dialogResult -eq "OK") {

        $hashTable = @{ }
        $i = 0;     
        foreach ($key in $propertiesOrder) {
            $hashTable[$key] = $textboxes[$i].Text
            $i++;
        }
        return $hashTable
    }
    else {
        throw "Execution was cancelled by the user"
    }

}