<?php
// Authors: Davi Leal
//
// Copyright (C) 2006 Davi Leal <davi at leals dot com>
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


require_once "../Layer-5__DB_operation/PostgreSQL.php";
// A lot of files from the Layer-5__DB_operation directory are loaded at the Layer-4 DB_Manager.php file. So it is not needed to load it here.

// Methods take the values form the global $_POST[] array.


class JobOffer
{
	private $postgresql;


	function __construct()
	{
		$this->postgresql = new PostgreSQL();
	}


	public function getJobOffersForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT J1_Id,J1_OfferDate,J1_ExpirationDate,J1_Closed,J1_VacancyTitle FROM J1_JobOffers WHERE J1_E1_Id=$1;  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);
		$array = array();
		$array[0] = pg_fetch_all_columns($result, 0);
		$array[1] = pg_fetch_all_columns($result, 1);
		$array[2] = pg_fetch_all_columns($result, 2);
		$array[3] = pg_fetch_all_columns($result, 3);
		$array[4] = pg_fetch_all_columns($result, 4);

		return $array;
	}

	public function getJobOffers()
	{
		$sqlQuery = "SELECT J1_Id, J1_Telework, J1_LO_Country,J1_StateProvince,J1_City, J1_OfferDate, E1_Id,E1_EntityType, E1_Website, EP_FirstName,EP_LastName,EP_MiddleName, EC_CompanyName, EO_OrganizationName, J1_VacancyTitle FROM J1_JobOffers,E1_Entities WHERE J1_E1_Id=E1_Id AND J1_Closed='f' AND J1_ExpirationDate > 'now'";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

		$array = array();

		$array[0] = pg_fetch_all_columns($result, 0); // J1_Id

		$array[1] = pg_fetch_all_columns($result, 1); // J1_Telework

		$array[2] = pg_fetch_all_columns($result, 2); // J1_LO_Country --> LO_Name
		for( $i=0; $i < count($array[2]); $i++)
		{
			if ( trim($array[2][$i]) != '' )
			{
				$e1_lo_country = $array[2][$i];
				$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e1_lo_country'";
				$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($loResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($loResult) == '1' )
				{
					$row = pg_fetch_object($loResult, 0);
					$array[2][$i] = trim($row->lo_name);
				}
			}
			else
				$array[2][$i] = '';
		}

		$array[3] = pg_fetch_all_columns($result, 3); // J1_StateProvince
		$array[4] = pg_fetch_all_columns($result, 4); // J1_City

		$array[5] = pg_fetch_all_columns($result, 5); // J1_OfferDate

		$array[6] = pg_fetch_all_columns($result, 6); // E1_Id
		$array[7] = pg_fetch_all_columns($result, 7); // E1_EntityType

		$array[8] = pg_fetch_all_columns($result, 8); // E1_Website

		$array[9] = pg_fetch_all_columns($result, 9); // EP_FirstName
		$array[10] = pg_fetch_all_columns($result, 10); // EP_LastName
		$array[11] = pg_fetch_all_columns($result, 11); // EP_MiddleName

		$array[12] = pg_fetch_all_columns($result, 12); // EC_CompanyName
		$array[13] = pg_fetch_all_columns($result, 13); // EO_OrganizationName

		$array[14] = pg_fetch_all_columns($result, 14); // J1_VacancyTitle

		return $array;
	}


	public function getJobOffer($Id)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT J1_EmployerJobOfferReference,J1_OfferDate,J1_ExpirationDate,J1_Closed,J1_HideEmployer,J1_AllowPersonApplications,J1_AllowCompanyApplications,J1_AllowOrganizationApplications,J1_Vacancies,J1_LK_ContractType,J1_WageRank,J1_LU_Currency,LU_PluralName,J1_LB_WageRankByPeriod,J1_ProfessionalExperienceSinceYear,J1_LA_Id,J1_FreeSoftwareProjects,J1_Telework,J1_City,J1_StateProvince,J1_LO_Country,J1_AvailableToTravel,J1_LO_JobLicenseAt,J1_VacancyTitle FROM J1_JobOffers,LU_Currencies WHERE J1_LU_Currency=LU_ThreeLetter AND J1_Id=$1;  EXECUTE query('$Id');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);

		$array = array();

		$array[0] = pg_fetch_all_columns($result, 0); // J1_EmployerJobOfferReference
		$array[1] = pg_fetch_all_columns($result, 1); // J1_OfferDate
		$array[2] = pg_fetch_all_columns($result, 2); // J1_ExpirationDate
		$array[3] = pg_fetch_all_columns($result, 3); // J1_Closed
		$array[4] = pg_fetch_all_columns($result, 4); // J1_HideEmployer

		$array[5] = pg_fetch_all_columns($result, 5); // J1_AllowPersonApplications
		$array[6] = pg_fetch_all_columns($result, 6); // J1_AllowCompanyApplications
		$array[7] = pg_fetch_all_columns($result, 7); // J1_AllowOrganizationApplications

		$array[8] = pg_fetch_all_columns($result, 8); // J1_Vacancies

		$array[9] = pg_fetch_all_columns($result, 9); // J1_LK_ContractType
		$array[10] = pg_fetch_all_columns($result, 10); // J1_WageRank
		$array[11] = pg_fetch_all_columns($result, 11); // J1_LU_Currency
		$array[12] = pg_fetch_all_columns($result, 12); // LU_PluralName
		$array[13] = pg_fetch_all_columns($result, 13); // J1_LB_WageRankByPeriod

		$array[14] = pg_fetch_all_columns($result, 14); // J1_ProfessionalExperienceSinceYear
		$array[15] = pg_fetch_all_columns($result, 15); // J1_LA_Id
		$array[16] = pg_fetch_all_columns($result, 16); // J1_FreeSoftwareProjects

		$array[17] = pg_fetch_all_columns($result, 17); // J1_Telework

		$array[18] = pg_fetch_all_columns($result, 18); // J1_City
		$array[19] = pg_fetch_all_columns($result, 19); // J1_StateProvince
		$array[20] = pg_fetch_all_columns($result, 20); // J1_LO_Country

		$array[21] = pg_fetch_all_columns($result, 21); // J1_AvailableToTravel

		$array[22] = pg_fetch_all_columns($result, 22); // J1_LO_JobLicenseAt

		for( $i=0; $i < count($array[20]); $i++) // LO_Name
		{
			if ( trim($array[20][$i]) != '' )
			{
				$e1_lo_country = $array[20][$i];
				$sqlQuery = "SELECT LO_Name FROM LO_Countries WHERE LO_TwoLetter='$e1_lo_country'";
				$loResult = $this->postgresql->getPostgreSQLObject($sqlQuery,0);

				$numrows = pg_num_rows($loResult);
				if ($numrows!=1) throw new Exception("ERROR:<pre> ASSERT raised: {$sqlQuery} </pre>",false);

				if ( pg_num_rows($loResult) == '1' )
				{
					$row = pg_fetch_object($loResult, 0);
					$array[25][$i] = trim($row->lo_name);
				}
			}
			else
				$array[25][$i] = '';
		}


		// Profiles

		$productProfiles = new ProductProfiles();
		$array[30] = $productProfiles->getProductProfilesForJobOffer($Id);

		$professionalProfiles = new ProfessionalProfiles();
		$array[31] = $professionalProfiles->getProfessionalProfilesForJobOffer($Id);

		$fieldProfiles = new FieldProfiles();
		$array[32] = $fieldProfiles->getFieldProfilesForJobOffer($Id);

		// Certifications
		$certifications = new Certifications();
		$array[50] = $certifications->getCertificationsForJobOffer($Id);

		// Languages table
		$languages = new Languages();
		$arrayLL = $languages->getLanguagesForJobOffer($Id);
		$array[40] = $arrayLL[0];
		$array[41] = $arrayLL[1];
		$array[42] = $arrayLL[2];

		// Skills table
		$skills = new Skills();
		$arrayLS = $skills->getSkillsForJobOffer($Id);
		$array[43] = $arrayLS[0];
		$array[44] = $arrayLS[1];
		$array[45] = $arrayLS[2];

		$array[60] = pg_fetch_all_columns($result, 23); // J1_VacancyTitle

		return $array;
	}


	public function addJobOffer()
	{
		// As there are several tables involved, we use a transaction to be sure, all operations are done, or nothing is done.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);


		// J1_JobOffers table

		$EntityId = isset($_SESSION['EntityId']) ? trim($_SESSION['EntityId']) : '';

		$VacancyTitle = $this->makeUp_VacancyTitle(); // Make up the VacancyTitle
		$EmployerJobOfferReference = isset($_POST['EmployerJobOfferReference']) ? trim($_POST['EmployerJobOfferReference']) : '';

		$ExpirationDate = isset($_POST['ExpirationDate']) ? trim($_POST['ExpirationDate']) : '';

		if (isset($_POST['Closed']) and $_POST['Closed'] == 'on')
			$Closed = 'true';
		else	$Closed = 'false';

		if (isset($_POST['HideEmployer']) and $_POST['HideEmployer'] == 'on')
			$HideEmployer = 'true';
		else	$HideEmployer = 'false';

		if (isset($_POST['AllowPersonApplications']) and $_POST['AllowPersonApplications'] == 'on')
			$AllowPersonApplications = 'true';
		else	$AllowPersonApplications = 'false';

		if (isset($_POST['AllowCompanyApplications']) and $_POST['AllowCompanyApplications'] == 'on')
			$AllowCompanyApplications = 'true';
		else	$AllowCompanyApplications = 'false';

		if (isset($_POST['AllowOrganizationApplications']) and $_POST['AllowOrganizationApplications'] == 'on')
			$AllowOrganizationApplications = 'true';
		else	$AllowOrganizationApplications = 'false';

		$Vacancies = isset($_POST['Vacancies']) ? trim($_POST['Vacancies']) : '';

		$ContractType = isset($_POST['ContractType']) ? trim($_POST['ContractType']) : '';
		$WageRank = isset($_POST['WageRank']) ? trim($_POST['WageRank']) : '';
		$WageRankCurrency = isset($_POST['WageRankCurrency']) ? trim($_POST['WageRankCurrency']) : '';
		$WageRankByPeriod = isset($_POST['WageRankByPeriod']) ? trim($_POST['WageRankByPeriod']) : '';

		$ProfessionalExperienceSinceYear = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';
		$AcademicQualification = isset($_POST['AcademicQualification']) ? trim($_POST['AcademicQualification']) : '';

		$FreeSoftwareExperiences = isset($_POST['FreeSoftwareExperiences']) ? trim($_POST['FreeSoftwareExperiences']) : '';

		if (isset($_POST['Telework']) and $_POST['Telework'] == 'on')
			$Telework = 'true';
		else	$Telework = 'false';

		$City = isset($_POST['City']) ? trim($_POST['City']) : '';
		$StateProvince = isset($_POST['StateProvince']) ? trim($_POST['StateProvince']) : '';
		$CountryCode = isset($_POST['CountryCode']) ? trim($_POST['CountryCode']) : '';

		if (isset($_POST['AvailableToTravel']) and $_POST['AvailableToTravel'] == 'on')
			$AvailableToTravel = 'true';
		else	$AvailableToTravel = 'false';

		$sqlQuery = "PREPARE query(integer,text,date,bool,bool,bool,bool,bool,text,text,text,text,text,text,text,text,text,bool,text,text,text,bool) AS  INSERT INTO J1_JobOffers (J1_E1_Id,J1_EmployerJobOfferReference,J1_OfferDate,J1_ExpirationDate,J1_Closed,J1_HideEmployer,J1_AllowPersonApplications,J1_AllowCompanyApplications,J1_AllowOrganizationApplications,J1_Vacancies,J1_VacancyTitle,J1_LK_ContractType,J1_WageRank,J1_LU_Currency,J1_LB_WageRankByPeriod,J1_ProfessionalExperienceSinceYear,J1_LA_Id,J1_FreeSoftwareProjects,J1_Telework,J1_City,J1_StateProvince,J1_LO_Country,J1_AvailableToTravel) VALUES ($1,$2,'now',$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22);  EXECUTE query('$EntityId','$EmployerJobOfferReference','$ExpirationDate','$Closed','$HideEmployer','$AllowPersonApplications','$AllowCompanyApplications','$AllowOrganizationApplications','$Vacancies','$VacancyTitle','$ContractType','$WageRank','$WageRankCurrency','$WageRankByPeriod','$ProfessionalExperienceSinceYear','$AcademicQualification','$FreeSoftwareExperiences','$Telework','$City','$StateProvince','$CountryCode','$AvailableToTravel');";
		$this->postgresql->getPostgreSQLObject($sqlQuery,1);


		// Get the Id of the insert to the J1_JobOffers table // Ref.: http://www.postgresql.org/docs/current/static/functions-sequence.html
		$sqlQuery = "SELECT currval('J1_JobOffers_j1_id_seq')";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,0);
		$array = pg_fetch_all_columns($result,0);
		$J1_Id = $array[0];

		// Certifications
		$certifications = new Certifications();
		$certifications->setCertificationsForJobOffer($J1_Id);

		// Profiles
		$productProfiles = new ProductProfiles();
		$productProfiles->setProductProfilesForJobOffer($J1_Id);

		$professionalProfiles = new ProfessionalProfiles();
		$professionalProfiles->setProfessionalProfilesForJobOffer($J1_Id);

		$fieldProfiles = new FieldProfiles();
		$fieldProfiles->setFieldProfilesForJobOffer($J1_Id);

		// Languages table
		$languages = new Languages();
		$languages->setLanguagesForJobOffer($J1_Id);

		// Skills table
		$skills = new Skills();
		$skills->setSkillsForJobOffer($J1_Id);


		$this->postgresql->execute("COMMIT",0);

		return $J1_Id;
	}


	private function deleteJobOffer($J1_Id)
	{
		// Delete the subscribed applicants
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1;  EXECUTE query('$J1_Id');";
		$result = $this->postgresql->execute($sqlQuery,1);

		// Certifications
		$certifications = new Certifications();
		$certifications->delCertificationsForJobOffer($J1_Id);

		// Profiles
		$productProfiles = new ProductProfiles();
		$productProfiles->delProductProfilesForJobOffer($J1_Id);

		$professionalProfiles = new ProfessionalProfiles();
		$professionalProfiles->delProfessionalProfilesForJobOffer($J1_Id);

		$fieldProfiles = new FieldProfiles();
		$fieldProfiles->delFieldProfilesForJobOffer($J1_Id);

		// Languages table
		$languages = new Languages();
		$languages->delLanguagesForJobOffer($J1_Id);

		// Skills table
		$skills = new Skills();
		$skills->delSkillsForJobOffer($J1_Id);

		// J1_JobOffers table
		$sqlQuery = "PREPARE query(integer) AS  DELETE FROM J1_JobOffers WHERE J1_Id=$1;  EXECUTE query('$J1_Id');";
		$result = $this->postgresql->execute($sqlQuery,1);
	}


	public function deleteSelectedJobOffers()
	{
		for ($i=0; $i < count($_POST['DeleteJobOffers']); $i++)
		{
			$this->deleteJobOffer( $_POST['DeleteJobOffers'][$i] );
		}
	}


	public function deleteJobOffersForEntity()
	{
		$joboffers = $this->getJobOffersForEntity();

		foreach ( $joboffers[0] as $J1_Id )
		{
			$this->deleteJobOffer( $J1_Id );
		}
	}


	public function updateJobOffer($J1_Id)
	{
		// As there are several tables involved, we use a transaction to be sure, all operations are done, or nothing is done.
		$this->postgresql->execute("SET TRANSACTION   ISOLATION LEVEL  SERIALIZABLE  READ WRITE",0);
		$this->postgresql->execute("BEGIN",0);


		// J1_JobOffers table

		$VacancyTitle = $this->makeUp_VacancyTitle(); // Make up the VacancyTitle
		$EmployerJobOfferReference = isset($_POST['EmployerJobOfferReference']) ? trim($_POST['EmployerJobOfferReference']) : '';

		$ExpirationDate = isset($_POST['ExpirationDate']) ? trim($_POST['ExpirationDate']) : '';

		if (isset($_POST['Closed']) and $_POST['Closed'] == 'on')
			$Closed = 'true';
		else	$Closed = 'false';

		if (isset($_POST['HideEmployer']) and $_POST['HideEmployer'] == 'on')
			$HideEmployer = 'true';
		else	$HideEmployer = 'false';

		if (isset($_POST['AllowPersonApplications']) and $_POST['AllowPersonApplications'] == 'on')
			$AllowPersonApplications = 'true';
		else	$AllowPersonApplications = 'false';

		if (isset($_POST['AllowCompanyApplications']) and $_POST['AllowCompanyApplications'] == 'on')
			$AllowCompanyApplications = 'true';
		else	$AllowCompanyApplications = 'false';

		if (isset($_POST['AllowOrganizationApplications']) and $_POST['AllowOrganizationApplications'] == 'on')
			$AllowOrganizationApplications = 'true';
		else	$AllowOrganizationApplications = 'false';

		$Vacancies = isset($_POST['Vacancies']) ? trim($_POST['Vacancies']) : '';

		$ContractType = isset($_POST['ContractType']) ? trim($_POST['ContractType']) : '';
		$WageRank = isset($_POST['WageRank']) ? trim($_POST['WageRank']) : '';
		$WageRankCurrency = isset($_POST['WageRankCurrency']) ? trim($_POST['WageRankCurrency']) : '';
		$WageRankByPeriod = isset($_POST['WageRankByPeriod']) ? trim($_POST['WageRankByPeriod']) : '';

		$ProfessionalExperienceSinceYear = isset($_POST['ProfessionalExperienceSinceYear']) ? trim($_POST['ProfessionalExperienceSinceYear']) : '';
		$AcademicQualification = isset($_POST['AcademicQualification']) ? trim($_POST['AcademicQualification']) : '';

		$FreeSoftwareExperiences = isset($_POST['FreeSoftwareExperiences']) ? trim($_POST['FreeSoftwareExperiences']) : '';

		if (isset($_POST['Telework']) and $_POST['Telework'] == 'on')
			$Telework = 'true';
		else	$Telework = 'false';

		$City = isset($_POST['City']) ? trim($_POST['City']) : '';
		$StateProvince = isset($_POST['StateProvince']) ? trim($_POST['StateProvince']) : '';
		$CountryCode = isset($_POST['CountryCode']) ? trim($_POST['CountryCode']) : '';

		if (isset($_POST['AvailableToTravel']) and $_POST['AvailableToTravel'] == 'on')
			$AvailableToTravel = 'true';
		else	$AvailableToTravel = 'false';

		$sqlQuery = "PREPARE query(text,date,bool,bool,bool,bool,bool,text,text,text,text,text,text,text,text,bool,text,text,text,bool,text,integer) AS  UPDATE J1_JobOffers SET J1_EmployerJobOfferReference=$1,J1_ExpirationDate=$2,J1_Closed=$3,J1_HideEmployer=$4,J1_AllowPersonApplications=$5,J1_AllowCompanyApplications=$6,J1_AllowOrganizationApplications=$7,J1_Vacancies=$8,J1_LK_ContractType=$9,J1_WageRank=$10,J1_LU_Currency=$11,J1_LB_WageRankByPeriod=$12,J1_ProfessionalExperienceSinceYear=$13,J1_LA_Id=$14,J1_FreeSoftwareProjects=$15,J1_Telework=$16,J1_City=$17,J1_StateProvince=$18,J1_LO_Country=$19,J1_AvailableToTravel=$20,J1_VacancyTitle=$21 WHERE J1_Id=$22;  EXECUTE query('$EmployerJobOfferReference','$ExpirationDate','$Closed','$HideEmployer','$AllowPersonApplications','$AllowCompanyApplications','$AllowOrganizationApplications','$Vacancies','$ContractType','$WageRank','$WageRankCurrency','$WageRankByPeriod','$ProfessionalExperienceSinceYear','$AcademicQualification','$FreeSoftwareExperiences','$Telework','$City','$StateProvince','$CountryCode','$AvailableToTravel','$VacancyTitle','$J1_Id');";
		$this->postgresql->execute($sqlQuery,1);


		// Certifications
		$certifications = new Certifications();
		$certifications->setCertificationsForJobOffer($J1_Id);

		// Profiles
		$productProfiles = new ProductProfiles();
		$productProfiles->setProductProfilesForJobOffer($J1_Id);

		$professionalProfiles = new ProfessionalProfiles();
		$professionalProfiles->setProfessionalProfilesForJobOffer($J1_Id);

		$fieldProfiles = new FieldProfiles();
		$fieldProfiles->setFieldProfilesForJobOffer($J1_Id);

		// Languages table
		$languages = new Languages();
		$languages->setLanguagesForJobOffer($J1_Id);

		// Skills table
		$skills = new Skills();
		$skills->setSkillsForJobOffer($J1_Id);


		$this->postgresql->execute("COMMIT",0);
	}


	public function getApplicationsMeterForJobOffer($Id, $meter)
	{
		$sqlQuery = "PREPARE query(integer,text) AS  SELECT count(R0_E1_Id) FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1 AND R0_State=$2;  EXECUTE query('$Id','$meter');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		return $result[0];
	}

	public function subscribeApplication($EntityId,$JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  INSERT INTO R0_Qualifications2JobOffersJoins (R0_J1_Id,R0_State,R0_E1_Id) VALUES ($1,'Received',$2);  EXECUTE query('$JobOfferId','$EntityId');";
		$this->postgresql->getPostgreSQLObject($sqlQuery,1);
		return true;
	}

	public function IsAlreadySubscribed($EntityId,$JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  SELECT R0_J1_Id FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1 AND R0_E1_Id=$2;  EXECUTE query('$JobOfferId','$EntityId');";
		$result = $this->postgresql->getOneField($sqlQuery,1);
		if ( is_array($result) and count($result)==1 )
			return true;
		else
			return false;
	}

	public function getJobOfferApplications($JobOfferId)
	{
		$arrayJO = $this->getJobOffer($JobOfferId);
		$array[0] =$arrayJO[60][0]; // J1ST_VacancyTitle

		$entities = $this->getEntitiesSubscribed($JobOfferId);
		if ( is_array($entities) and count($entities)>0 )
		{
			for ($i=0; $i<count($entities); $i++)
			{
				$array[1][$i] = $entities[$i]; // EntityId

				$entity = new Entity();
				$arrayEN = $entity->getEntity($entities[$i]);

				$array[2][$i] = $arrayEN[2][0]; // E1_EntityType

				$array[3][$i] = $arrayEN[3][0]; // E1_Street
				$array[4][$i] = $arrayEN[5][0]; // E1_City
				$array[5][$i] = $arrayEN[6][0]; // E1_StateProvince

				$array[6][$i] = $arrayEN[15][0]; // E1_Website

				$array[7][$i] = $arrayEN[16][0]; // EP_FirstName
				$array[8][$i] = $arrayEN[17][0]; // EP_LastName
				$array[9][$i] = $arrayEN[18][0]; // EP_MiddleName

				$array[10][$i] = $arrayEN[19][0]; // EC_CompanyName
				$array[11][$i] = $arrayEN[20][0]; // EO_OrganizationName

				$array[12][$i] = $arrayEN[30][0]; // LO_Name

				$qualifications = new Qualifications();
				$arrayQA = $qualifications->getQualificationsForEntity($entities[$i]);

				$array[13][$i] = $arrayQA[0][0]; // Q1_ProfessionalExperienceSinceYear
				$array[14][$i] = $arrayQA[1][0]; // Q1_LA_Id

				$arraySS = $this->getApplicationState($JobOfferId,$entities[$i]);
				$array[15][$i] = $arraySS[0]; // R0_State
			}
		}

		return $array;
	}

	private function getEntitiesSubscribed($JobOfferId)
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT R0_E1_Id FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1;  EXECUTE query('$JobOfferId');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	private function getApplicationState($JobOfferId,$EntityId)
	{
		$sqlQuery = "PREPARE query(integer,integer) AS  SELECT R0_State FROM R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=$1 AND R0_E1_Id=$2;  EXECUTE query('$JobOfferId','$EntityId');";
		return $this->postgresql->getOneField($sqlQuery,1);
	}

	public function setApplicationState($JobOfferId,$State,$EntityId)
	{
		$sqlQuery = "PREPARE query(text,integer,integer) AS  UPDATE R0_Qualifications2JobOffersJoins SET R0_State=$1 WHERE R0_J1_Id=$2 AND R0_E1_Id=$3;  EXECUTE query('$State','$JobOfferId','$EntityId');";
		return $this->postgresql->execute($sqlQuery,1);
	}


	public function getJobApplicationsForEntity()
	{
		$sqlQuery = "PREPARE query(integer) AS  SELECT J1_Id,J1_E1_Id,J1_OfferDate,R0_State,J1_VacancyTitle FROM J1_JobOffers,R0_Qualifications2JobOffersJoins WHERE R0_J1_Id=J1_Id AND R0_E1_Id=$1 AND J1_Closed='f' AND J1_ExpirationDate > 'now' ;  EXECUTE query('$_SESSION[EntityId]');";
		$result = $this->postgresql->getPostgreSQLObject($sqlQuery,1);
		$array = array();
		$array[0] = pg_fetch_all_columns($result, 0);
		$array[1] = pg_fetch_all_columns($result, 1);
		$array[2] = pg_fetch_all_columns($result, 2);
		$array[3] = pg_fetch_all_columns($result, 3);
		$array[4] = pg_fetch_all_columns($result, 4);

		return $array;
	}


	private function makeUp_VacancyTitle()
	{
		define("MAX_LENGTH",100);

		$VacancyTitle = $_POST['ProfessionalProfileList'][0];

		for( $i=1; $i < count($_POST['ProfessionalProfileList']); $i++)
			if ( strlen($VacancyTitle.", ".$_POST['ProfessionalProfileList'][$i]) < MAX_LENGTH )
				$VacancyTitle .= ", ".$_POST['ProfessionalProfileList'][$i];

		for( $i=0; $i < count($_POST['FieldProfileList']); $i++)
			if ( strlen($VacancyTitle.", ".$_POST['FieldProfileList'][$i]) < MAX_LENGTH )
				$VacancyTitle .= ", ".$_POST['FieldProfileList'][$i];

		for( $i=0; $i < count($_POST['SkillList']); $i++)
			if ( strlen($VacancyTitle.", ".$_POST['SkillList'][$i]) < MAX_LENGTH )
				$VacancyTitle .= ", ".$_POST['SkillList'][$i];

		for( $i=0; $i < count($_POST['LanguageList']); $i++)
			if ( strlen($VacancyTitle.", ".$_POST['LanguageList'][$i]) < MAX_LENGTH )
				$VacancyTitle .= ", ".$_POST['LanguageList'][$i];

		return $VacancyTitle;
	}
}
?> 
