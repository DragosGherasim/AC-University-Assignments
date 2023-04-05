import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.ArrayList;

public class JTableTiobe {
    private final JFrame f;
    private final DefaultTableModel model;
    JTableTiobe(DataBase db){
        f = new JFrame();
        f.setTitle("SQLite example");

        String[] colHeads = {"May2019", "May2018", "Change", "Programming Language", "Ratings"};
        String[][] data = {};

        model = new DefaultTableModel(data, colHeads);

        JTable j = new JTable(data, colHeads);
        j.setBounds(30, 40, 800, 300);

        JButton loadButton = new JButton("Load");
        loadButton.addActionListener(e -> {
            model.setRowCount(0);

            ArrayList<ProgrammingLanguageTiobe> data1 = db.SelectInJTable();
            for(ProgrammingLanguageTiobe progLang : data1){
                model.addRow(new Object[]{progLang.getMay2019(), progLang.getMay2018(),
                    progLang.getChange(), progLang.getName(), progLang.getRating()});
            }
        });

        JButton saveButton = new JButton("Save");
        saveButton.addActionListener(e -> {
            for (int i = 0; i < model.getRowCount(); i++) {
                int may2019 = Integer.parseInt(model.getValueAt(i, 0).toString());
                int may2018 = Integer.parseInt(model.getValueAt(i, 1).toString());
                String change = model.getValueAt(i, 2).toString();
                String programmingLanguage = model.getValueAt(i, 3).toString();
                String ratings = model.getValueAt(i, 4).toString();

                ProgrammingLanguageTiobe pl = new ProgrammingLanguageTiobe(may2019, may2018, change, programmingLanguage, ratings);
                db.UpdateFromJTable(pl, i + 1);
            }

            JOptionPane.showMessageDialog(f, "Changes saved successfully.");
        });

        j.setModel(model);

        JPanel buttonPanel = new JPanel();
        buttonPanel.add(loadButton);
        buttonPanel.add(saveButton);

        JScrollPane sp = new JScrollPane(j);
        f.add(buttonPanel, BorderLayout.SOUTH);
        f.add(sp, BorderLayout.CENTER);
        f.setSize(800, 400);

        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                f.dispose(); // Close the JFrame and release all resources
            }
        });

        f.setVisible(true);
    }
}
