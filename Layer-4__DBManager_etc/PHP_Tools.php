<?php
// Authors: Davi Leal
// 
// Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>
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


class PHPTools
{
	public function resetPHPsession()
	{
		$language = $_SESSION['Language'];

		// Unset all of the session variables.
		session_unset();

		// We do not destroy the session with session_destroy()
		// due to we want to recover the $language.

		$_SESSION['Language'] = $language;
	}

	public function cleanPHPsession()
	{
		$language = $_SESSION['Language'];
		$loginType = $_SESSION['LoginType'];
		$entityId = $_SESSION['EntityId'];

		// Unset all of the session variables.
		session_unset();

		// We do not destroy the session with session_destroy()
		// due to we want to recover the $language.

		$_SESSION['Language'] = $language;
		$_SESSION['LoginType'] = $loginType;
		$_SESSION['EntityId'] = $entityId;
		$_SESSION['Logged'] = '1';
	}
}
?>
