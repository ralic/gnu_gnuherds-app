<?php
// Authors: Davi Leal
//
// Copyright (C) 2007 Davi Leal <davi at leals dot com>
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the Affero General Public License as published by Affero Inc.,
// either version 1 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful to the Free
// Software community, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
// General Public License for more details.
//
// You should have received a copy of the Affero General Public License with this
// software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
// Suite 225, San Francisco, CA 94107, USA


require_once "../Layer-4__DBManager_etc/DB_Manager.php";


class AlertsForm
{
	private $manager;
	private $processingResult;


	function __construct()
	{
		$this->manager = new DBManager();
		$this->processingResult = '';
	}


	public function processForm()
	{
		$phpTools = new PHPTools();

		// Check the log in state and load the data
		if ( $_SESSION['Logged'] != '1' )
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( isset($_POST['save']) and $_POST['save'] == gettext('Save') )
			$this->saveAlertsForm();
		else
			$this->loadAlertsForm();
	}


	public function printOutput()
	{
		if ( $_POST['save'] == gettext('Save') )
			echo $this->processingResult;
		else
			$this->printAlertsForm();
	}


	private function printAlertsForm()
	{
		$smarty = new Smarty;
		$smarty->display("Alerts_form.tpl");
	}


	private function saveAlertsForm()
	{
		if (isset($_POST['NewJobOffer']) and $_POST['NewJobOffer']=='on')
			$_SESSION['NewJobOffer'] = "true";
		else
			$_SESSION['NewJobOffer'] = "false";

		$this->manager->saveAlertsForEntity();
		$this->processingResult .= "<p>&nbsp;</p><p>".gettext('Updated successfully')."</p><p>&nbsp;</p>\n";
	}


	private function loadAlertsForm()
	{
		$result = $this->manager->getAlertsForEntity();

		if ($result[0][0]=='t')
			$_SESSION['NewJobOffer'] = "true";
		else
			$_SESSION['NewJobOffer'] = "false";

		return true;
	}
}
?> 
