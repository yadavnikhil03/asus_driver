Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    try {
        Start-Process -FilePath "powershell.exe" -ArgumentList $arguments -Verb RunAs -ErrorAction Stop
    }
    catch {
        [System.Windows.MessageBox]::Show("This script requires administrator privileges to install drivers. Please run it as Administrator.", "Admin Rights Required", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
    }
    Exit
}
Import-Module BitsTransfer -ErrorAction SilentlyContinue

$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
if ($Host.Name -eq "ConsoleHost") {
    chcp 65001 | Out-Null
}
Clear-Host

$AsciiArtBase64 = "4qO/4qO/4qO/4qO/4qO/4qGf4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKjv+Kjv+Kjv+Kjv+Kjv+Kgg+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArio7/io7/io7/io7/io7/ioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qO/4qO/4qO/4qO/4qO/4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qGA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qKA4qCA4qCA4qCA4qKw4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKjv+Kjv+Kjv+Kjv+Kjv+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKioOKhh+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKiuOKggOKggOKggOKiuOKhgOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArio7/io7/io7/io7/ioZ/ioIDioIbioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIHioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioJjioIDioIDioIDiopjioYfioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioLDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qO/4qO/4qO/4qO/4qGH4qGH4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qKA4qCA4qCA4qCA4qCA4qK54qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qKA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKjv+Kjv+Kjv+Kjv+Khh+Kjv+KgsOKhgOKgiOKghOKggOKggOKggOKggOKggOKggOKggOKis+KjhOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKiuOKggOKggOKggOKggOKggOKhh+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKigOKjv+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArio7/io7/io7/io7/io4fiorvioYfiorPioYDioIDioIDioIDioIDioIDioIDioIDioIDioIDioJnioIfioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioJjioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioL7ioL/ioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qOE4qKz4qGE4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCI4qCg4qCA4qCA4qCA4qCA4qCA4qCA4qCh4qGA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+KhhuKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgseKjhOKggOKggOKggOKggOKggOKgmOKghuKggOKgiOKiv+KjpuKggOKggOKgoOKggOKggOKggOKggOKggOKisOKjtuKjtuKgguKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArio7/io7/io7/io7/io7/io7/io7/ioI/ioIDioIDiobbioIDioIDioIDioIDioIDioIDioIDioIDiooDio7TioYTioIDioIDioIDioIDioIDioIDioJjio6bio4DioIDioIDioIDioqDio4DioIDioIDioIjioLPioKbioIDioIDioIDioIDioIDioIDioJDioIDiorvioZ/ioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qO/4qO/4qO/4qO/4qO/4qG/4qCD4qCc4qCA4qCC4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCY4qO/4qOH4qCA4qCA4qCA4qO34qOE4qCA4qCA4qCI4qCb4qK34qO24qOk4qGE4qCZ4qCz4qCm4qOk4qGA4qCI4qCA4qCA4qCA4qGA4qC44qOk4qOE4qCA4qCA4qCA4qGA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKjv+Kjv+Kjv+Kjv+Kgn+KioOKgjuKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKigOKggOKgiOKgu+Kgt+KghuKisOKjv+Kjv+Kjt+KjpOKhgOKgiOKgu+Kjv+Kjv+Kjv+KjpuKjpOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgiOKgieKgoOKggOKggOKigOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArio7/io7/iob/iooPio7TioI/ioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioLjiorbio7bio4TioITiorDio7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io4/ioInioIDiooDio6Dio7Tio7bio7bio7bio6bioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDiooDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qO/4qCL4qOw4qO/4qCL4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qO/4qOm4qGA4qKA4qO+4qOE4qCg4qCZ4qK/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qGA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qKA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKjoeKjv+Kjv+Kgg+KggOKggOKggOKggOKgoOKggOKggOKggOKggOKggOKggOKggOKggOKisOKhv+Kii+KjtOKjv+Kjv+Kjv+Kjv+KjpuKjpOKhueKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjp+KhgeKggOKgiOKgieKgm+Kgm+Kgv+Kjv+Kjt+KjgOKhkOKgoOKgt+KjvOKgguKggOKgiOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKiuOKhh+KggOKggOKggOKggOKggOKggOKggArio7/iob/ioIPioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDio4nio7Tio7/io7/io7/io7/io7/io7/io7/io7/io7/io6/ioZvior/io7/io7/io7/io7/io7/io7/io7/io7fio7Tio4bio6DioYDioIDioIDioInioJvioJvioJvioIvioInioIDiooDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioLjioIDioIDioIDioIDioIDioIDioIDioIAK4qO/4qGh4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qOg4qO+4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO24qKM4qGb4qK/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qOm4qOm4qOE4qOA4qOA4qGg4qCA4qGk4qCL4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKhu+KggeKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgmOKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Khv+Kiv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Khv+Kgi+KigOKjpOKjhOKjoOKjtOKgn+KigeKhtOKggeKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgiOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIjior/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/ioZvior/io7/io7/io7/io7Tio7/io7/io7/ioJ/io4HioJTio6vio7TioIDioYDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qCA4qCA4qCA4qGg4qCA4qCA4qGQ4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qGJ4qK/4qG/4qC74qC/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qOt4qOA4qGC4qCJ4qKb4qC74qC/4qKL4qCl4qKK4qOh4qO+4qO/4qO34qGE4qCA4qKg4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKggOKggOKhlOKggeKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKiu+KjhuKju+Kjv+Kjt+KjrOKjueKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+KjtuKjpuKjjOKjkuKgguKgreKgjeKgm+Kgu+Kiv+Kgg+KggOKjuOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggAriooDioZzioYDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDiorjio7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io77ioIDioIDio7/ioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qCI4qO04qCB4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCI4qK74qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qCA4qCA4qGf4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKjvuKgj+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgiOKgu+Kiv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+KgmOKggOKjp+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArioIHioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDio4DioJniorvio7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/ioIDioIDiornioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qG+4qCC4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qO/4qO/4qO/4qOm4qOM4qCb4qK/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgu+Kjv+Kjv+Kjv+Kjv+Kjv+KjtuKjhOKhmeKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+KioOKggOKioOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioojioJnioL/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/iorjioYfioJjioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qO04qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCI4qO34qO24qOs4qO94qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qCI4qCB4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKgi+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kgv+Kgm+KgieKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDiorjio7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/iob/ioL/ioJvioInioIDioIDio4Dio6Dio7Tio7biobbioIPioJDioYDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qK44qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qC/4qC/4qCf4qCL4qCJ4qOB4qOg4qOk4qO24qO24qO/4qO/4qO/4qO/4qO/4qGf4qKh4qGG4qKj4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKggOKggOKggOKggOKggOKggOKggOKggOKggOKhuOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgiOKgu+Kiv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Khv+Kgv+Kgn+Kgm+Kgm+KgieKgieKggOKggOKggOKgm+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+KjtuKjv+Khh+KggOKggOKgguKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArioIDioIDioIDioIDioIDioIDioIDioIDioIDioIPioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIjiorvio7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/ioYfioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qC54qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qGf4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCACuKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKgueKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kgn+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggArioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDiorvio7/io7/io7/io7/io7/ioJ/ioIvioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIAK4qCA4qCA4qCA4qGG4qCA4qCA4qCA4qCA4qCA4qCD4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCY4qK74qG/4qCb4qKJ4qCk4qCC4qCB4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qKA4qOACuKjoOKhhuKggOKgl+KggOKggOKggOKggOKiueKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggeKhoOKiiuKjoeKgnuKggeKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKigOKjpOKjtuKjv+Kjv+Kjvwrio77ioYfioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIjio7Tiob/ioIvioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDio6Dio77io7/io7/io7/io7/io7/io78K4qCL4qCA4qCA4qKA4qGA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCB4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qOg4qO04qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/CuKggOKggOKggOKiuuKjh+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKioOKjvuKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjvwrio6DioYTioIDiorjio7/ioYDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDioIDio7Dio7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io7/io78K4qO/4qGH4qCA4qCA4qO/4qO34qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCA4qCi4qCA4qCA4qCA4qCA4qCA4qCA4qO84qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/4qO/CuKiuOKhh+KggOKhhuKiueKjv+Kjp+KggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKggOKhoOKggOKggOKggOKggOKggOKguuKgg+KggOKggOKggOKigOKhgOKjtOKjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjv+Kjvw=="
$AsciiArtBytes = [System.Convert]::FromBase64String($AsciiArtBase64)
$AsciiArt = [System.Text.Encoding]::UTF8.GetString($AsciiArtBytes)
Write-Host $AsciiArt -ForegroundColor Magenta

Write-Host ""
Write-Host " ===========================================================================" -ForegroundColor Cyan
Write-Host "  ASUS TUF DRIVER UTILITY V1.0.0" -ForegroundColor Magenta -NoNewline
Write-Host " | Developed by: " -ForegroundColor Cyan -NoNewline
Write-Host "@yadavnikhil03" -ForegroundColor Magenta
Write-Host "  GitHub Profile: https://github.com/yadavnikhil03" -ForegroundColor Magenta
Write-Host " ===========================================================================" -ForegroundColor Cyan
Write-Host "  WHY THIS UTILITY WAS CREATED:" -ForegroundColor Magenta
Write-Host "  - To automate clean, post-reinstall driver setup on ASUS TUF laptops." -ForegroundColor White
Write-Host "  - Eliminates the hassle of manually searching, downloading, and installing" -ForegroundColor White
Write-Host "    individual setup packages or running heavy vendor bloatware." -ForegroundColor White
Write-Host "  - Provides sequential silent/automated and manual installation paths." -ForegroundColor White
Write-Host " ===========================================================================" -ForegroundColor Cyan
Write-Host ""

$Global:BrushConverter = New-Object System.Windows.Media.BrushConverter

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
if ([string]::IsNullOrEmpty($ScriptDir)) { $ScriptDir = Get-Location }

$JsonPath = Join-Path $ScriptDir "drivers.json"
$LogPath = Join-Path $ScriptDir "install_log.txt"

if (-not (Test-Path -Path $JsonPath)) {
    [System.Windows.MessageBox]::Show("Could not find database file: drivers.json`n`nPlease make sure drivers.json is in the same folder as this script.", "Configuration Missing", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
    Exit
}

try {
    $Drivers = Get-Content -Path $JsonPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
}
catch {
    [System.Windows.MessageBox]::Show("Failed to parse drivers.json. Please ensure it is valid JSON.`n`nError: $($_.Exception.Message)", "JSON Parse Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
    Exit
}

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="ASUS TUF Driver Installer" Height="700" Width="850" Background="#0C0A15"
        WindowStartupLocation="CenterScreen" ResizeMode="CanResize">
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#161324"/>
            <Setter Property="Foreground" Value="#E6E1F5"/>
            <Setter Property="BorderBrush" Value="#2A2244"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="16,8"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Style.Resources>
                <Style TargetType="Border">
                    <Setter Property="CornerRadius" Value="4"/>
                </Style>
            </Style.Resources>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#251C3B"/>
                    <Setter Property="BorderBrush" Value="#FF4B91"/>
                </Trigger>
                <Trigger Property="IsEnabled" Value="False">
                    <Setter Property="Background" Value="#0E0C17"/>
                    <Setter Property="Foreground" Value="#5E5875"/>
                    <Setter Property="BorderBrush" Value="#1C172E"/>
                </Trigger>
            </Style.Triggers>
        </Style>
        
        <Style x:Key="PrimaryBtn" TargetType="Button" BasedOn="{StaticResource {x:Type Button}}">
            <Setter Property="Background" Value="#FF4B91"/>
            <Setter Property="Foreground" Value="#0C0A15"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True">
                    <Setter Property="Background" Value="#FF7DB7"/>
                </Trigger>
                <Trigger Property="IsEnabled" Value="False">
                    <Setter Property="Background" Value="#3C1B2A"/>
                    <Setter Property="Foreground" Value="#7D7599"/>
                </Trigger>
            </Style.Triggers>
        </Style>

        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#E6E1F5"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="CheckBox">
                        <BulletDecorator Background="Transparent">
                            <BulletDecorator.Bullet>
                                <Border x:Name="Border" Width="14" Height="14" BorderBrush="#2A2244" BorderThickness="1.5" Background="#120E24" CornerRadius="3">
                                    <Path x:Name="CheckMark" Width="8" Height="6" SnapsToDevicePixels="True" Stroke="#FF4B91" StrokeThickness="2" Data="M0,2 L3,5 L8,0" Visibility="Collapsed" Margin="1,2,0,0"/>
                                </Border>
                            </BulletDecorator.Bullet>
                            <ContentPresenter Margin="8,0,0,0" VerticalAlignment="Center" HorizontalAlignment="Left" RecognizesAccessKey="True"/>
                        </BulletDecorator>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsChecked" Value="true">
                                <Setter TargetName="CheckMark" Property="Visibility" Value="Visible"/>
                                <Setter TargetName="Border" Property="BorderBrush" Value="#FF4B91"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="true">
                                <Setter TargetName="Border" Property="BorderBrush" Value="#FF4B91"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style TargetType="RadioButton">
            <Setter Property="Foreground" Value="#E6E1F5"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="RadioButton">
                        <BulletDecorator Background="Transparent">
                            <BulletDecorator.Bullet>
                                <Border x:Name="Border" Width="14" Height="14" BorderBrush="#2A2244" BorderThickness="1.5" Background="#120E24" CornerRadius="7">
                                    <Ellipse x:Name="CheckMark" Width="6" Height="6" Fill="#FF4B91" Visibility="Collapsed" Margin="2.5"/>
                                </Border>
                            </BulletDecorator.Bullet>
                            <ContentPresenter Margin="8,0,0,0" VerticalAlignment="Center" HorizontalAlignment="Left" RecognizesAccessKey="True"/>
                        </BulletDecorator>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsChecked" Value="true">
                                <Setter TargetName="CheckMark" Property="Visibility" Value="Visible"/>
                                <Setter TargetName="Border" Property="BorderBrush" Value="#FF4B91"/>
                            </Trigger>
                            <Trigger Property="IsMouseOver" Value="true">
                                <Setter TargetName="Border" Property="BorderBrush" Value="#FF4B91"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style TargetType="ToolTip">
            <Setter Property="Background" Value="#161324"/>
            <Setter Property="Foreground" Value="#E6E1F5"/>
            <Setter Property="BorderBrush" Value="#FF4B91"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="12,8"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontSize" Value="11.5"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="ToolTip">
                        <Border Background="{TemplateBinding Background}"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                Padding="{TemplateBinding Padding}"
                                CornerRadius="4">
                            <TextBlock Text="{TemplateBinding Content}" TextWrapping="Wrap" MaxWidth="400" Foreground="#E6E1F5"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Storyboard x:Key="SuccessAnimation">
            <DoubleAnimation Storyboard.TargetName="SuccessOverlay"
                             Storyboard.TargetProperty="Opacity"
                             From="0" To="1" Duration="0:0:0.4"/>
            <DoubleAnimation Storyboard.TargetName="SuccessTranslate"
                             Storyboard.TargetProperty="Y"
                             From="40" To="0" Duration="0:0:0.4">
                <DoubleAnimation.EasingFunction>
                    <CubicEase EasingMode="EaseOut"/>
                </DoubleAnimation.EasingFunction>
            </DoubleAnimation>
        </Storyboard>
    </Window.Resources>
    
    <Grid>
        <Grid Margin="20">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="130"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            
            <Border Grid.Row="0" Background="#120E24" Padding="15" Margin="0,0,0,12" BorderBrush="#2A2244" BorderThickness="1" CornerRadius="4">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="Auto"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel>
                        <TextBlock Text="ASUS TUF DRIVER UTILITY V1.0.0" FontSize="16" FontWeight="Bold" Foreground="#FF4B91" FontFamily="Segoe UI Semibold"/>
                        <TextBlock Text="Hardware-validated driver installation console" FontSize="11" Foreground="#7D7599" Margin="0,2,0,0"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1" VerticalAlignment="Center" HorizontalAlignment="Right">
                        <TextBlock Name="StatusSummaryText" Text="Ready" Foreground="#00F0FF" FontWeight="SemiBold" FontSize="12" HorizontalAlignment="Right"/>
                        <StackPanel Orientation="Horizontal" Margin="0,4,0,0">
                            <TextBlock Text="CONSOLE BY " Foreground="#5E5875" FontSize="9.5" FontWeight="Bold"/>
                            <TextBlock Name="TxtAuthor" Text="@yadavnikhil03" Foreground="#FF4B91" FontSize="10" FontWeight="Bold" Cursor="Hand" ToolTip="Open @yadavnikhil03's GitHub profile."/>
                        </StackPanel>
                    </StackPanel>
                </Grid>
            </Border>

            <Grid Grid.Row="1" Margin="0,0,0,12">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                
                <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                    <Button Name="BtnSelectAll" Content="SELECT ALL" Padding="12,5" Margin="0,0,8,0" FontSize="11" ToolTip="Check all drivers in the list."/>
                    <Button Name="BtnDeselectAll" Content="DESELECT ALL" Padding="12,5" Margin="0,0,20,0" FontSize="11" ToolTip="Uncheck all drivers in the list."/>
                    
                    <TextBlock Text="MODE:" VerticalAlignment="Center" Foreground="#E6E1F5" Margin="0,0,10,0" FontWeight="Bold" FontSize="11"/>
                    <RadioButton Name="RadSilent" Content="AUTOMATED (SILENT)" Foreground="#E6E1F5" IsChecked="True" VerticalAlignment="Center" Margin="0,0,15,0" FontSize="11" ToolTip="AUTOMATIC: Installs everything automatically in one click. You don't have to click Next or Finish."/>
                    <RadioButton Name="RadInteractive" Content="INTERACTIVE" Foreground="#E6E1F5" VerticalAlignment="Center" FontSize="11" ToolTip="MANUAL: Opens the setup wizard for each driver. You will click Next and Finish yourself."/>
                </StackPanel>
                
                <CheckBox Grid.Column="1" Name="ChkUseWinget" Content="PREFER WINGET" Foreground="#E6E1F5" IsChecked="False" VerticalAlignment="Center" FontSize="11" ToolTip="Downloads and installs drivers from Microsoft Store/Winget (fully automatic)."/>
            </Grid>
            
            <Border Grid.Row="2" Background="#0C0A15" BorderBrush="#2A2244" BorderThickness="1" CornerRadius="4" Margin="0,0,0,12">
                <ScrollViewer VerticalScrollBarVisibility="Auto" Padding="0">
                    <StackPanel Name="DriverContainer"/>
                </ScrollViewer>
            </Border>
            
            <Grid Grid.Row="3" Margin="0,0,0,12">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <ProgressBar Name="MainProgressBar" Height="8" Background="#120E24" Foreground="#FF4B91" BorderThickness="0" Minimum="0" Maximum="100" Value="0">
                    <ProgressBar.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="4"/>
                        </Style>
                    </ProgressBar.Resources>
                </ProgressBar>
                <TextBlock Grid.Column="1" Name="ProgressText" Text="0%" Foreground="#E6E1F5" FontWeight="Bold" Margin="12,0,0,0" VerticalAlignment="Center" FontSize="11"/>
            </Grid>
            
            <TextBox Grid.Row="4" Name="TxtLogs" Background="#06050C" Foreground="#00FFC4" BorderBrush="#2A2244" BorderThickness="1" 
                     IsReadOnly="True" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto" FontFamily="Consolas" FontSize="11" Padding="10" Margin="0,0,0,12">
                <TextBox.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="4"/>
                    </Style>
                </TextBox.Resources>
            </TextBox>
            
            <Grid Grid.Row="5">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <TextBlock Text="* Requires administrative credentials. Background installations run silently." Foreground="#5E5875" VerticalAlignment="Center" FontSize="10.5"/>
                <StackPanel Grid.Column="1" Orientation="Horizontal">
                    <Button Name="BtnInstall" Style="{StaticResource PrimaryBtn}" Content="RUN INSTALLATION" Padding="24,10" Margin="0,0,10,0" FontSize="12" ToolTip="Starts downloading and installing all checked drivers."/>
                    <Button Name="BtnClose" Content="EXIT" Padding="20,10" FontSize="12" ToolTip="Close this program."/>
                </StackPanel>
            </Grid>
        </Grid>

        <Grid x:Name="SuccessOverlay" Visibility="Collapsed" Background="#E60C0A15" Opacity="0">
            <Grid.RenderTransform>
                <TranslateTransform x:Name="SuccessTranslate" Y="40"/>
            </Grid.RenderTransform>
            
            <Border Background="#120E24" BorderBrush="#FF4B91" BorderThickness="1" CornerRadius="6" Width="420" Height="290" HorizontalAlignment="Center" VerticalAlignment="Center">
                <Grid Margin="25">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <Grid Grid.Row="0" HorizontalAlignment="Center" Margin="0,0,0,15">
                        <Ellipse Width="50" Height="50" Stroke="#FF4B91" StrokeThickness="2"/>
                        <Path Width="16" Height="12" Stroke="#FF4B91" StrokeThickness="3" StrokeEndLineCap="Round" StrokeStartLineCap="Round" Data="M0,4 L5,9 L14,0" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="0,2,0,0"/>
                    </Grid>
                    
                    <TextBlock Grid.Row="1" Text="SYSTEM READY" FontSize="18" FontWeight="Bold" Foreground="#FF4B91" FontFamily="Segoe UI Semibold" HorizontalAlignment="Center"/>
                    
                    <StackPanel Grid.Row="2" Margin="0,12,0,12" HorizontalAlignment="Center">
                        <TextBlock Text="ASUS TUF driver configuration completed successfully." Foreground="#E6E1F5" FontSize="12.5" TextAlignment="Center"/>
                        <TextBlock x:Name="SuccessSummaryText" Text="Installed: 0 | Failed: 0" Foreground="#7D7599" FontSize="11.5" Margin="0,6,0,0" TextAlignment="Center"/>
                    </StackPanel>
                    
                    <StackPanel Grid.Row="3" Orientation="Vertical" HorizontalAlignment="Stretch">
                        <Button Name="BtnRestart" Style="{StaticResource PrimaryBtn}" Content="RESTART LAPTOP" Height="38" HorizontalAlignment="Stretch" Margin="0,0,0,8"/>
                        <Button Name="BtnSuccessClose" Content="CLOSE" Height="32" HorizontalAlignment="Stretch"/>
                    </StackPanel>
                </Grid>
            </Border>
        </Grid>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

$BtnInstall = $window.FindName("BtnInstall")
$BtnClose = $window.FindName("BtnClose")
$BtnSelectAll = $window.FindName("BtnSelectAll")
$BtnDeselectAll = $window.FindName("BtnDeselectAll")
$RadSilent = $window.FindName("RadSilent")
$RadInteractive = $window.FindName("RadInteractive")
$ChkUseWinget = $window.FindName("ChkUseWinget")
$DriverContainer = $window.FindName("DriverContainer")
$MainProgressBar = $window.FindName("MainProgressBar")
$ProgressText = $window.FindName("ProgressText")
$StatusSummaryText = $window.FindName("StatusSummaryText")
$TxtLogs = $window.FindName("TxtLogs")
$SuccessOverlay = $window.FindName("SuccessOverlay")
$SuccessSummaryText = $window.FindName("SuccessSummaryText")
$BtnRestart = $window.FindName("BtnRestart")
$BtnSuccessClose = $window.FindName("BtnSuccessClose")
$TxtAuthor = $window.FindName("TxtAuthor")

function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "HH:mm:ss"
    $formattedMsg = "[$timestamp] $message`r`n"
    
    $window.Dispatcher.Invoke([System.Action]{
        $TxtLogs.AppendText($formattedMsg)
        $TxtLogs.ScrollToEnd()
    })
    
    $logMsg = "[$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))] $message"
    Add-Content -Path $LogPath -Value $logMsg -Encoding UTF8 -ErrorAction SilentlyContinue
}

function Wait-ProcessResponsive($process) {
    while (-not $process.HasExited) {
        [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke(
            [System.Windows.Threading.DispatcherPriority]::Background,
            [System.Action]{}
        )
        Start-Sleep -Milliseconds 100
    }
    return $process.ExitCode
}

function Download-FileResponsive($url, $destination) {
    Write-Log "Downloading from: $url"
    Write-Log "Saving to: $destination"
    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    if ($url -like "*drive.google.com*" -or $url -like "*docs.google.com*") {
        Write-Log "Google Drive URL detected. Processing direct download..."
        $fileId = $null
        if ($url -match '/d/([a-zA-Z0-9_-]+)') {
            $fileId = $Matches[1]
        } elseif ($url -match 'id=([a-zA-Z0-9_-]+)') {
            $fileId = $Matches[1]
        }
        
        if ([string]::IsNullOrEmpty($fileId)) {
            Write-Log "Error: Could not extract Google Drive File ID from URL."
            return $false
        }
        
        Write-Log "Extracted File ID: $fileId"
        $downloadUrl = "https://drive.usercontent.google.com/download?id=$fileId&export=download&confirm=t"
        Write-Log "Using direct download URL: $downloadUrl"
        
        try {
            $request = [System.Net.HttpWebRequest]::Create($downloadUrl)
            $request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
            $request.Method = "GET"
            $request.AllowAutoRedirect = $true
            $request.MaximumAutomaticRedirections = 10
            
            $response = $request.GetResponse()
            $contentType = $response.ContentType
            $contentLength = $response.ContentLength
            Write-Log "Response: $contentType, Size: $([math]::Round($contentLength / 1MB, 2)) MB"
            
            if ($contentType -like "*text/html*") {
                $response.Close()
                Write-Log "Error: Google Drive returned HTML instead of file. The file may not be publicly shared."
                return $false
            }
            
            $responseStream = $response.GetResponseStream()
            $fileStream = [System.IO.File]::Create($destination)
            
            $buffer = New-Object byte[] 65536
            $totalRead = 0
            while (($read = $responseStream.Read($buffer, 0, $buffer.Length)) -gt 0) {
                $fileStream.Write($buffer, 0, $read)
                $totalRead += $read
                
                [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke(
                    [System.Windows.Threading.DispatcherPriority]::Background,
                    [System.Action]{}
                )
            }
            
            $fileStream.Close()
            $responseStream.Close()
            $response.Close()
            
            Write-Log "Google Drive download successful. Total: $([math]::Round($totalRead / 1MB, 2)) MB"
            return $true
        }
        catch {
            Write-Log "Google Drive download error: $($_.Exception.Message)"
            if (Test-Path -Path $destination) { Remove-Item -Path $destination -Force -ErrorAction SilentlyContinue }
            return $false
        }
    }
    
    try {
        $job = Start-BitsTransfer -Source $url -Destination $destination -Asynchronous -ErrorAction Stop
        
        while ($job.JobState -eq "Transferring" -or $job.JobState -eq "Connecting") {
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke(
                [System.Windows.Threading.DispatcherPriority]::Background,
                [System.Action]{}
            )
            Start-Sleep -Milliseconds 250
        }
        
        if ($job.JobState -eq "Error") {
            $err = $job.ErrorDescription
            Cancel-BitsTransfer -BitsJob $job
            throw $err
        }
        
        Complete-BitsTransfer -BitsJob $job
        Write-Log "Download successful via BITS."
        return $true
    }
    catch {
        Write-Log "BITS failed or unavailable ($($_.Exception.Message)). Falling back to WebClient..."
        try {
            $webClient = New-Object System.Net.WebClient
            $webClient.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
            
            $uri = New-Object System.Uri($url)
            $webClient.DownloadFileAsync($uri, $destination)
            
            while ($webClient.IsBusy) {
                [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke(
                    [System.Windows.Threading.DispatcherPriority]::Background,
                    [System.Action]{}
                )
                Start-Sleep -Milliseconds 250
            }
            Write-Log "Download successful via WebClient."
            return $true
        }
        catch {
            Write-Log "Download failed completely: $($_.Exception.Message)"
            return $false
        }
    }
}

$DriverRows = @()
foreach ($driver in $Drivers) {
    $filePath = Join-Path $ScriptDir $driver.FileName
    $localExists = Test-Path -Path $filePath
    
    $border = New-Object System.Windows.Controls.Border
    $border.Background = $BrushConverter.ConvertFromString("#120E24")
    $border.Margin = New-Object System.Windows.Thickness(0,0,0,6)
    $border.BorderBrush = $BrushConverter.ConvertFromString("#2A2244")
    $border.BorderThickness = New-Object System.Windows.Thickness(1)
    $border.Padding = New-Object System.Windows.Thickness(16,10,16,10)
    $border.CornerRadius = New-Object System.Windows.CornerRadius(4)
    
    $grid = New-Object System.Windows.Controls.Grid
    
    $col0 = New-Object System.Windows.Controls.ColumnDefinition; $col0.Width = [System.Windows.GridLength]::Auto
    $col1 = New-Object System.Windows.Controls.ColumnDefinition; $col1.Width = New-Object System.Windows.GridLength(1, [System.Windows.GridUnitType]::Star)
    $col2 = New-Object System.Windows.Controls.ColumnDefinition; $col2.Width = [System.Windows.GridLength]::Auto
    $col3 = New-Object System.Windows.Controls.ColumnDefinition; $col3.Width = [System.Windows.GridLength]::Auto
    
    [void]$grid.ColumnDefinitions.Add($col0)
    [void]$grid.ColumnDefinitions.Add($col1)
    [void]$grid.ColumnDefinitions.Add($col2)
    [void]$grid.ColumnDefinitions.Add($col3)
    
    $chk = New-Object System.Windows.Controls.CheckBox
    $chk.IsChecked = $true
    $chk.Margin = New-Object System.Windows.Thickness(0,0,16,0)
    $chk.VerticalAlignment = [System.Windows.VerticalAlignment]::Center
    [System.Windows.Controls.Grid]::SetColumn($chk, 0)
    [void]$grid.Children.Add($chk)
    
    $stackText = New-Object System.Windows.Controls.StackPanel
    
    $txtTitle = New-Object System.Windows.Controls.TextBlock
    $txtTitle.Text = $driver.FriendlyName.ToUpper()
    $txtTitle.FontWeight = [System.Windows.FontWeights]::SemiBold
    $txtTitle.Foreground = $BrushConverter.ConvertFromString("#E6E1F5")
    $txtTitle.FontSize = 12
    $txtTitle.FontFamily = New-Object System.Windows.Media.FontFamily("Segoe UI")
    $txtTitle.TextWrapping = [System.Windows.TextWrapping]::Wrap
    
    $txtSub = New-Object System.Windows.Controls.TextBlock
    $txtSub.Text = "$($driver.Category.ToUpper())  |  $($driver.FileName)"
    $txtSub.Foreground = $BrushConverter.ConvertFromString("#7D7599")
    $txtSub.FontSize = 9.5
    $txtSub.Margin = New-Object System.Windows.Thickness(0,3,0,0)
    $txtSub.FontFamily = New-Object System.Windows.Media.FontFamily("Segoe UI")
    $txtSub.TextWrapping = [System.Windows.TextWrapping]::Wrap
    
    [void]$stackText.Children.Add($txtTitle)
    [void]$stackText.Children.Add($txtSub)
    [System.Windows.Controls.Grid]::SetColumn($stackText, 1)
    [void]$grid.Children.Add($stackText)
    
    $txtStatus = New-Object System.Windows.Controls.TextBlock
    if ($localExists) {
        $txtStatus.Text = "READY"
        $txtStatus.Foreground = $BrushConverter.ConvertFromString("#7D7599")
    } else {
        $txtStatus.Text = "ONLINE ONLY"
        $txtStatus.Foreground = $BrushConverter.ConvertFromString("#00F0FF")
    }
    $txtStatus.FontWeight = [System.Windows.FontWeights]::Bold
    $txtStatus.VerticalAlignment = [System.Windows.VerticalAlignment]::Center
    $txtStatus.Margin = New-Object System.Windows.Thickness(0,0,16,0)
    $txtStatus.FontSize = 10.5
    [System.Windows.Controls.Grid]::SetColumn($txtStatus, 2)
    [void]$grid.Children.Add($txtStatus)
    
    $btnAction = New-Object System.Windows.Controls.Button
    $btnAction.Content = "DOWNLOAD"
    $btnAction.Padding = New-Object System.Windows.Thickness(12,4,12,4)
    $btnAction.FontSize = 10
    $btnAction.Margin = New-Object System.Windows.Thickness(0,0,5,0)
    [System.Windows.Controls.Grid]::SetColumn($btnAction, 3)
    $btnAction.ToolTip = "Download this driver from the internet."
    
    if ($localExists) {
        $btnAction.Visibility = [System.Windows.Visibility]::Collapsed
    } else {
        $btnAction.Visibility = [System.Windows.Visibility]::Visible
    }
    
    $btnAction.Add_Click({
        $btnAction.IsEnabled = $false
        $txtStatus.Text = "DOWNLOADING..."
        $txtStatus.Foreground = $BrushConverter.ConvertFromString("#00F0FF")
        
        $targetPath = Join-Path $ScriptDir $driver.FileName
        $success = Download-FileResponsive $driver.DownloadUrl $targetPath
        
        if ($success) {
            $txtStatus.Text = "READY"
            $txtStatus.Foreground = $BrushConverter.ConvertFromString("#7D7599")
            $btnAction.Visibility = [System.Windows.Visibility]::Collapsed
        } else {
            $txtStatus.Text = "FAILED"
            $txtStatus.Foreground = $BrushConverter.ConvertFromString("#FF3366")
            $btnAction.IsEnabled = $true
        }
    })
    
    [void]$grid.Children.Add($btnAction)
    
    $border.Child = $grid
    [void]$DriverContainer.Children.Add($border)
    
    $DriverRows += [PSCustomObject]@{
        DriverInfo = $driver
        Border = $border
        CheckBox = $chk
        StatusText = $txtStatus
        ActionButton = $btnAction
    }
}

$BtnSelectAll.Add_Click({
    foreach ($row in $DriverRows) {
        $row.CheckBox.IsChecked = $true
    }
})

$BtnDeselectAll.Add_Click({
    foreach ($row in $DriverRows) {
        $row.CheckBox.IsChecked = $false
    }
})

function Reset-UI {
    $BtnInstall.IsEnabled = $true
    $BtnSelectAll.IsEnabled = $true
    $BtnDeselectAll.IsEnabled = $true
    $RadSilent.IsEnabled = $true
    $RadInteractive.IsEnabled = $true
    $ChkUseWinget.IsEnabled = $true
}

$BtnInstall.Add_Click({
    $selected = $DriverRows | Where-Object { $_.CheckBox.IsChecked }
    $total = $selected.Count
    
    if ($total -eq 0) {
        [System.Windows.MessageBox]::Show("No items are selected for installation.", "Selection Required", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning)
        return
    }
    
    $BtnInstall.IsEnabled = $false
    $BtnSelectAll.IsEnabled = $false
    $BtnDeselectAll.IsEnabled = $false
    $RadSilent.IsEnabled = $false
    $RadInteractive.IsEnabled = $false
    $ChkUseWinget.IsEnabled = $false
    
    $MainProgressBar.Maximum = $total
    $MainProgressBar.Value = 0
    $ProgressText.Text = "0%"
    $StatusSummaryText.Text = "RUNNING: 0 / $total"
    
    Write-Log "=== Starting Driver Installer Session ($total selected) ==="
    
    $successCount = 0
    $failCount = 0
    $index = 0
    
    foreach ($row in $selected) {
        $index++
        $driver = $row.DriverInfo
        Write-Log "Processing: $($driver.FriendlyName) ($index / $total)..."
        
        $row.StatusText.Text = "INSTALLING..."
        $row.StatusText.Foreground = $BrushConverter.ConvertFromString("#FF4B91")
        $row.Border.Background = $BrushConverter.ConvertFromString("#221223")
        $row.Border.BorderBrush = $BrushConverter.ConvertFromString("#FF4B91")
        $row.Border.BorderThickness = New-Object System.Windows.Thickness(1)
        
        [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke([System.Windows.Threading.DispatcherPriority]::Background, [System.Action]{})
        
        $installed = $false
        $useWinget = $ChkUseWinget.IsChecked -and -not [string]::IsNullOrEmpty($driver.WingetId)
        
        $localPath = Join-Path $ScriptDir $driver.FileName
        $tempDir = Join-Path $env:TEMP "TufDriversCache"
        $tempPath = Join-Path $tempDir $driver.FileName
        $installPath = $null
        $isTemp = $false
        
        if ($useWinget) {
            Write-Log "Attempting install via winget with ID: $($driver.WingetId)"
            $row.StatusText.Text = "WINGET INSTALL..."
            
            $args = "install --id $($driver.WingetId) --silent --accept-package-agreements --accept-source-agreements"
            try {
                $p = Start-Process -FilePath "winget" -ArgumentList $args -PassThru -NoNewWindow
                $exitCode = Wait-ProcessResponsive $p
                if ($exitCode -eq 0) {
                    Write-Log "Winget install successful."
                    $installed = $true
                } else {
                    Write-Log "Winget failed with exit code $exitCode."
                }
            }
            catch {
                Write-Log "Winget command execution failed: $($_.Exception.Message)"
            }
        }
        
        if (-not $installed) {
            if (Test-Path -Path $localPath) {
                $installPath = $localPath
                $isTemp = $false
                Write-Log "Found local installer: $localPath"
            } elseif (Test-Path -Path $tempPath) {
                $installPath = $tempPath
                $isTemp = $true
                Write-Log "Found previously downloaded installer in temp directory: $tempPath"
            } else {
                if (-not [string]::IsNullOrEmpty($driver.DownloadUrl)) {
                    Write-Log "Installer not found locally. Starting download to temp directory..."
                    $row.StatusText.Text = "DOWNLOADING..."
                    
                    if (-not (Test-Path -Path $tempDir)) { New-Item -ItemType Directory -Path $tempDir -Force | Out-Null }
                    
                    $dlSuccess = Download-FileResponsive $driver.DownloadUrl $tempPath
                    if ($dlSuccess) {
                        $installPath = $tempPath
                        $isTemp = $true
                    } else {
                        Write-Log "Download failed."
                    }
                } else {
                    Write-Log "No local file and no download URL specified."
                }
            }
            
            if ($installPath -ne $null) {
                Write-Log "Running installer: $(Split-Path $installPath -Leaf)"
                
                try {
                    if ($RadSilent.IsChecked) {
                        Write-Log "Executing silently: $(Split-Path $installPath -Leaf) $($driver.SilentArgs)"
                        $p = Start-Process -FilePath $installPath -ArgumentList $driver.SilentArgs -PassThru -NoNewWindow
                        $exitCode = Wait-ProcessResponsive $p
                        
                        if ($exitCode -eq 0 -or $exitCode -eq 3010) {
                            Write-Log "Installation succeeded. (Exit code: $exitCode)"
                            $installed = $true
                        } else {
                            Write-Log "Installation returned error code: $exitCode"
                        }
                    } else {
                        Write-Log "Executing interactively. Waiting for user setup wizard to close..."
                        $p = Start-Process -FilePath $installPath -PassThru
                        $exitCode = Wait-ProcessResponsive $p
                        Write-Log "Installer closed. (Exit code: $exitCode)"
                        $installed = $true
                    }
                }
                catch {
                    Write-Log "Failed to execute installer: $($_.Exception.Message)"
                }
                
                if ($isTemp -and (Test-Path -Path $installPath)) {
                    Write-Log "Cleaning up temporary installer file: $installPath"
                    Remove-Item -Path $installPath -Force -ErrorAction SilentlyContinue
                }
            }
        }
        
        if ($installed) {
            $successCount++
            $row.StatusText.Text = "SUCCESS"
            $row.StatusText.Foreground = $BrushConverter.ConvertFromString("#00FFC4")
            $row.Border.Background = $BrushConverter.ConvertFromString("#0A1F18")
            $row.Border.BorderBrush = $BrushConverter.ConvertFromString("#00FFC4")
            $row.Border.BorderThickness = New-Object System.Windows.Thickness(1)
            $row.CheckBox.IsChecked = $false
        } else {
            $failCount++
            $row.StatusText.Text = "FAILED"
            $row.StatusText.Foreground = $BrushConverter.ConvertFromString("#FF3366")
            $row.Border.Background = $BrushConverter.ConvertFromString("#2B0F1A")
            $row.Border.BorderBrush = $BrushConverter.ConvertFromString("#FF3366")
            $row.Border.BorderThickness = New-Object System.Windows.Thickness(1)
        }
        
        $MainProgressBar.Value = $index
        $pct = [math]::Round(($index / $total) * 100)
        $ProgressText.Text = "$pct%"
        $StatusSummaryText.Text = "RUNNING: $index / $total"
        
        [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke([System.Windows.Threading.DispatcherPriority]::Background, [System.Action]{})
    }
    
    Write-Log "=== Installation Complete. Succeeded: $successCount, Failed: $failCount ==="
    $StatusSummaryText.Text = "FINISHED"
    
    $SuccessSummaryText.Text = "Installed: $successCount  |  Failed: $failCount"
    $SuccessOverlay.Visibility = [System.Windows.Visibility]::Visible
    $storyboard = $window.Resources["SuccessAnimation"]
    $storyboard.Begin()
})

$BtnRestart.Add_Click({
    Restart-Computer -Force
})

$BtnSuccessClose.Add_Click({
    $SuccessOverlay.Visibility = [System.Windows.Visibility]::Collapsed
    Reset-UI
})

$BtnClose.Add_Click({
    $window.Close()
})

$TxtAuthor.Add_MouseDown({
    Start-Process "https://github.com/yadavnikhil03"
})


$startupMsg = "$AsciiArt`r`n`r`n=== ASUS TUF Driver Installer Initialized ===`r`nLoaded $($Drivers.Count) drivers from configuration.`r`nReady to begin."
Write-Log $startupMsg

$window.ShowDialog() | Out-Null
