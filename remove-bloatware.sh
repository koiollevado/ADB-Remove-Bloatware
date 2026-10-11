#!/bin/bash

# Nome do arquivo com os pacotes a serem desinstalados
input_file=uninstall-20240825.txt
# Nome do script de desinstalação a ser gerado
output_script=uninstall_bloatware.sh

# Verifica se o arquivo de entrada existe
if [ ! -f $input_file ]; then
  echo "Arquivo $input_file não encontrado."
  exit 1
fi

# Cria o script de desinstalação
echo "#!/bin/bash" > $output_script
echo "" >> $output_script

# Lê o arquivo linha por linha e adiciona os comandos ao script de desinstalação
while IFS= read -r package_name; do
  echo "adb shell pm clear $package_name" >> $output_script
  echo "adb shell pm uninstall --user 0 $package_name" >> $output_script
done < $input_file

# Dá permissão de execução ao script gerado
chmod +x $output_script

echo "Script $output_script criado e permissão de execução concedida."
