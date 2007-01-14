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


require_once "../Layer-4__DBManager_etc/DB_Manager.php";


class DeletePhotoOrLogo
{
	private function goBack()
	{
		if ( $_SESSION['LoginType'] == 'Person' )
			$request_uri = "Person.php"; // The request come from that URI
		elseif ( $_SESSION['LoginType'] == 'Company' )
			$request_uri = "Company.php";
		elseif ( $_SESSION['LoginType'] == 'non-profit Organization' )
			$request_uri = "non-profit_Organization.php";

		header("Location: https://$_SERVER[HTTP_HOST]/$request_uri");
	}

	public function deletePhotoOrLogo()
	{
		$manager = new DBManager();
		$manager->deletePhotoOrLogo();

		$this->goBack();
	}
}
?>