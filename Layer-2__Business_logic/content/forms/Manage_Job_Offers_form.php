<?php
// Authors: Davi Leal
//
// Copyright (C) 2006, 2007, 2008 Davi Leal <davi at leals dot com>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License as published by the Free Software Foundation,
// either version 3 of the License, or (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
// General Public License for more details.
// 
// You should have received a copy of the GNU Affero General Public License along with this
// program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.


require_once "../Layer-4__DBManager_etc/DB_Manager.php";

// Methods take the values from the global $_POST[] array.


class ManageJobOffersForm
{
	private $manager;
	private $processingResult;
	private $data;


	function __construct()
	{
		$this->manager = new DBManager();
		$this->processingResult = '';
	}


	public function processForm()
	{
		// Check the log in state
		if ( $_SESSION['Logged'] == '1' )
		{
			if ( $_SESSION['LoginType'] != 'Person' && $_SESSION['LoginType'] != 'Company' && $_SESSION['LoginType'] != 'non-profit Organization' )
			{
				$error = "<p>".gettext('To access this section you have to login first.')."</p>";
				throw new Exception($error,false);
			}
		}
		else
		{
			$error = "<p>".gettext('To access this section you have to login first.')."</p>";
			throw new Exception($error,false);
		}

		// Process each button event
		if ( $_POST['delete'] != '' )
		{
			if ( count($_POST['DeleteJobOffers']) >= 1 or count($_POST['CancelDonations']) >= 1 )
			{
				if ( $_GET['section'] == 'pledges' )
				{
					$this->manager->cancelSelectedDonations();
				}
				else
				{
					$this->manager->deleteSelectedJobOffers();
				}
			}
		}
	}


	public function printOutput()
	{
		$this->printManageJobOffersForm();
	}


	private function printManageJobOffersForm()
	{
		$smarty = new Smarty;


		// Entries

		switch ($_GET["section"]) {
			case "": case "offers":
				$offerType = "Job offer";
				break;

			case "pledges":
				$offerType = "Donation pledge group";
				break;

			case "volunteers":
				$offerType = "Looking for volunteers";
				break;

			default:
				$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
				throw new Exception($error,false);
		}
		$result = $this->manager->getJobOffersForEntity(" AND J1_OfferType='".$offerType."' ");

		$this->data['JobOfferId'] = $result[0];
		$this->data['OfferDate'] = $result[1];
		$this->data['ExpirationDate'] = $result[2];
		$this->data['Closed'] = $result[3];
		$this->data['VacancyTitle'] = isset($result[4]) ? $result[4] : '';
		$this->data['OfferType'] = $result[5];


		// Details

		switch ($_GET["section"]) {
			case "": case "offers": // Meters
				$receivedMeter = array();
				$inProcessMeter = array();
				$ruledOutMeter = array();
				$finalistMeter = array();
				$selectedMeter = array();

				for ($i=0; $i < count($result[0]); $i++)
				{
					$receivedMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Received' );
					$inProcessMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'In process' );
					$ruledOutMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Ruled out' );
					$finalistMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Finalist' );
					$selectedMeter[$i] = $this->manager->getApplicationsMeterForJobOffer( $result[0][$i], 'Selected' );
				}

				$smarty->assign('ReceivedMeter', $receivedMeter); //XXX: DELAYED: Set directly to $this->data['Meters'] the information got from getApplicationsMeterForJobOffer()
				$smarty->assign('InProcessMeter', $inProcessMeter);
				$smarty->assign('RuledOutMeter', $ruledOutMeter);
				$smarty->assign('FinalistMeter', $finalistMeter);
				$smarty->assign('SelectedMeter', $selectedMeter);

				break;

			case "pledges": // Donations
				for ($i=0; $i < count($result[0]); $i++)
				{
					$this->data['Donations'][$i] = $this->manager->getDonationsForPledgeGroup( $result[0][$i] );
					$this->data['MyDonations'][$i] = $this->manager->getMyDonationsForPledgeGroup( $result[0][$i] );
				}
				break;

			case "volunteers":
				break;

			default:
				$error = "<p>".$_SERVER["REQUEST_URI"].": ".gettext('ERROR: Unexpected condition')."</p>";
				throw new Exception($error,false);
		}


		// Show

		$smarty->assign('data', $this->data);
		$smarty->display("Manage_Job_Offers_form.tpl");
	}
}
?> 
