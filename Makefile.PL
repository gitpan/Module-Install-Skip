use inc::Module::Install;

name		('Module-Install-Skip');
abstract	('Module::Install extension that allow skip files with regexp');
version_from	('lib/Module/Install/Skip.pm');
author		('Ruslan U. Zakirov <cubic@wildgate.miee.ru>');
license		('perl');

&WriteAll;
