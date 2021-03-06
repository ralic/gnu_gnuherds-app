<?php
// Authors: Davi Leal
// 
// Copyright (C) 2007, 2008, 2009 Davi Leal <davi at leals dot com>
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


require_once "../Layer-2__Business_logic/others/Language_form.php";
require_once "../Layer-4__DBManager_etc/DB_Manager.php";


function raiseAlertsFor($alert_type) // Raise any alert type
{
	$manager = new DBManager();
	$languageForm = new LanguageForm();

	// Before do anything, check if there are $alert_type alerts to raise.
	if ( $manager->pendingAlerts($alert_type) == false )
		return;

	// Get the language set (E1_LL_Locale). Only for the entities who has this $alert_type alert activated. If there are no any entity, we do nothing in the next 'for' loop.
	$languages = $manager->getAlertsLocales($alert_type);

	// For each E1_LL_Locale:
	for ( $i=0; $i < count($languages); $i++ )
	{
		// Set the locale
		$languageForm->setLocale($languages[$i]);

		// Set language for mb_language()
		mb_language("uni"); //XXX: Add support to Japanese, etc.  Reference: http://es.php.net/manual/en/function.mb-language.php

		// Get the email set (E1_Email), and its alerts behavior flags (A1_AlertMeOnMyOwnNotices), for entities using that (E1_Locale)
		$to = $manager->getAlertsEmails($alert_type,$languages[$i]);

		// Get the array which describes what we are going to alert, with some parts already localized
		switch($alert_type)
		{
			case 'NewJobOffer':
				$offer_type = 'Job offer';
				break;
			case 'NewDonationPledgeGroup':
				$offer_type = 'Donation pledge group';
				break;
			case 'NewLookForVolunteers':
				$offer_type = 'Looking for volunteers';
				break;
			default:
				$error = gettext("ERROR: Unexpected condition");
				throw new Exception($error,false);
		}
		$joboffers = $manager->getJobOffers(" AND J1_OfferType='${offer_type}' AND J1_CompletedEdition='t' AND J1_${alert_type}Alert='t' ");

		// Send emails
		for ( $j=0; $j < count($to['Email']); $j++ )
		{
			if ( count($joboffers['JobOfferId']) > 0 )
			{
				// Write the email
				switch($alert_type)
				{
					case 'NewJobOffer':

						// Create the message's subject
						$subject = "GNU Herds: ".gettext("Alert on new job offers");

						// Create the message's body
						$body = "";
						for ( $k=0; $k < count($joboffers['JobOfferId']); $k++ )
						{
							if (  $to['Email'][$j] != $joboffers['Email'][$k]   ||   ( $to['Email'][$j] == $joboffers['Email'][$k] && $to['AlertMeOnMyOwnNotices'][$j] == 't' )  )
							{
								$body .= gettext("Vacancy title").":  ".$joboffers['VacancyTitle'][$k]."\n";
								$body .= gettext("Location").":  ";
								if ( trim($joboffers['Country'][$k]) == '' )
								{
									$body .= dgettext('database', "Any").", ".gettext("telework");
								}
								else
								{
									$body .= gettext($joboffers['Country'][$k]);
									if ($joboffers['StateProvince'][$k] != '') $body .= ", ".$joboffers['StateProvince'][$k];
									if ($joboffers['City'][$k] != '') $body .= ", ".$joboffers['City'][$k];
								}
								$body .= "\n";

								//XXX-remove-this-line:  $body .= gettext("Offer date").": ";
								//XXX-remove-this-line:  $body .= $joboffers['OfferDate'][$k]."\n";

								$body .= gettext("Offered by").":  ";
								if ($joboffers['FirstName'][$k] != '') $body .= gettext("Person").": ";
								if ($joboffers['CooperativeName'][$k] != '') $body .= gettext("Cooperative").": ";
								if ($joboffers['CompanyName'][$k] != '') $body .= gettext("Company").": ";
								if ($joboffers['OrganizationName'][$k] != '') $body .= gettext("non-profit Organization").": ";

								if ($joboffers['FirstName'][$k] != '')
								{
									$body .= $joboffers['LastName'][$k].$joboffers['MiddleName'][$k];
									if ($joboffers['LastName'][$k] != '' or $joboffers['MiddleName'][$k] != '') $body .= ", ";
									$body .= $joboffers['FirstName'][$k]."\n";
								}
								if ($joboffers['CooperativeName'][$k] != '') $body .= $joboffers['CooperativeName'][$k]."\n";
								if ($joboffers['CompanyName'][$k] != '') $body .= $joboffers['CompanyName'][$k]."\n";
								if ($joboffers['OrganizationName'][$k] != '') $body .= $joboffers['OrganizationName'][$k]."\n";

								$body .= "\n";

								$body .= "  https://gnuherds.org/offers?id=".$joboffers['JobOfferId'][$k]."\n";

								$body .= "\n";
								$body .= "\n";
							}
						}

						break;

					case 'NewDonationPledgeGroup':

						// Create the message's subject
						$subject = "GNU Herds: ".gettext("Alert on new donation pledge groups");

						// Create the message's body
						$body = "";
						for ( $k=0; $k < count($joboffers['JobOfferId']); $k++ )
						{
							if (  $to['Email'][$j] != $joboffers['Email'][$k]   ||   ( $to['Email'][$j] == $joboffers['Email'][$k] && $to['AlertMeOnMyOwnNotices'][$j] == 't' )  )
							{
								$body .= gettext("Vacancy title").":  ".$joboffers['VacancyTitle'][$k]."\n";
								$body .= gettext("Location").":  ".dgettext('database', "Any").", ".gettext("telework")."\n";

								$body .= "\n";

								$body .= "  https://gnuherds.org/pledges?id=".$joboffers['JobOfferId'][$k]."\n";

								$body .= "\n";
								$body .= "\n";
							}
						}

						break;

					case 'NewLookForVolunteers':

						// Create the message's subject
						$subject = "GNU Herds: ".gettext("Alert on new look-for-volunteers notices");

						// Create the message's body
						$body = "";
						for ( $k=0; $k < count($joboffers['JobOfferId']); $k++ )
						{
							if (  $to['Email'][$j] != $joboffers['Email'][$k]   ||   ( $to['Email'][$j] == $joboffers['Email'][$k] && $to['AlertMeOnMyOwnNotices'][$j] == 't' )  )
							{
								$body .= gettext("Vacancy title").":  ".$joboffers['VacancyTitle'][$k]."\n";

								$body .= "\n";

								$body .= "  https://gnuherds.org/volunteers?id=".$joboffers['JobOfferId'][$k]."\n";

								$body .= "\n";
								$body .= "\n";
							}
						}

						break;

					default:
						$error = gettext("ERROR: Unexpected condition");
						throw new Exception($error,false);
				}

				if ( $body != "" )
				{
					$body .= "--\n";
					$body .= vsprintf(gettext('You can disable this type of alerts at  %s'),"https://gnuherds.org/settings \n");

					mb_send_mail($to['Email'][$j], $subject, $body, "From: association@gnuherds.org");
				}
			}
		}
	}

	// We disable the $alert_type alerts due to they have been just processed
	$manager->resetAlerts($alert_type);
}


// Raise the alerts
raiseAlertsFor('NewJobOffer');
raiseAlertsFor('NewDonationPledgeGroup');
raiseAlertsFor('NewLookForVolunteers');
?> 
